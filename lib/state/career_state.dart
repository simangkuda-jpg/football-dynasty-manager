import 'package:flutter/foundation.dart';
import '../data/models/manager.dart';
import '../data/models/club.dart';
import '../data/models/player.dart';
import '../data/models/match_models.dart';
import '../data/models/tactic.dart';
import '../data/seed/seed_data.dart';
import '../engine/match_engine.dart';
import '../save/save_service.dart';

class CareerState extends ChangeNotifier {
  Manager? manager;
  List<Club> clubs = [];
  List<Player> players = [];
  List<Fixture> fixtures = [];
  int currentMatchday = 1;
  bool loaded = false;

  Club? get myClub => manager == null ? null : clubs.firstWhere((c) => c.id == manager!.clubId);

  List<Player> squadOf(String clubId) => players.where((p) => p.clubId == clubId).toList();

  Player? playerById(String id) {
    try {
      return players.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Club? clubById(String id) {
    try {
      return clubs.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  void startNewCareer({
    required String managerName,
    required String managerNationality,
    required String chosenClubId,
  }) {
    final seed = SeedData.generate();
    clubs = seed.clubs;
    players = seed.players;
    manager = Manager(
      id: 'manager_1',
      name: managerName,
      nationality: managerNationality,
      clubId: chosenClubId,
    );
    fixtures = _generateRoundRobinFixtures(clubs);
    currentMatchday = 1;
    loaded = true;
    notifyListeners();
  }

  List<Fixture> _generateRoundRobinFixtures(List<Club> clubList) {
    final ids = clubList.map((c) => c.id).toList();
    if (ids.length.isOdd) ids.add('BYE');
    final n = ids.length;
    final rounds = n - 1;
    final half = n ~/ 2;
    final generated = <Fixture>[];
    var teams = List<String>.from(ids);
    int fixtureCounter = 0;

    for (int round = 0; round < rounds; round++) {
      for (int i = 0; i < half; i++) {
        final home = teams[i];
        final away = teams[n - 1 - i];
        if (home != 'BYE' && away != 'BYE') {
          generated.add(Fixture(
            id: 'fixture_${fixtureCounter++}',
            homeClubId: round.isEven ? home : away,
            awayClubId: round.isEven ? away : home,
            matchday: round + 1,
          ));
        }
      }
      final fixed = teams[0];
      final rest = teams.sublist(1);
      rest.insert(0, rest.removeLast());
      teams = [fixed, ...rest];
    }

    return generated;
  }

  List<Fixture> fixturesForMatchday(int matchday) => fixtures.where((f) => f.matchday == matchday).toList();

  int get lastMatchday => fixtures.isEmpty ? 1 : fixtures.map((f) => f.matchday).reduce((a, b) => a > b ? a : b);

  void updateTactic(String clubId, Tactic tactic) {
    final club = clubById(clubId);
    if (club == null) return;
    club.tactic = tactic;
    notifyListeners();
  }

  void simulateMatchday() {
    final todays = fixturesForMatchday(currentMatchday);
    for (final fixture in todays) {
      if (fixture.isPlayed) continue;
      final home = clubById(fixture.homeClubId)!;
      final away = clubById(fixture.awayClubId)!;
      final homeSquad = squadOf(home.id);
      final awaySquad = squadOf(away.id);

      final result = MatchEngine.simulate(
        matchId: fixture.id,
        homeClub: home,
        awayClub: away,
        homePlayers: homeSquad,
        awayPlayers: awaySquad,
      );

      fixture.result = result;
      _applyResultToTable(home, away, result);
    }
    currentMatchday++;
    notifyListeners();
  }

  void _applyResultToTable(Club home, Club away, MatchResult result) {
    home.played++;
    away.played++;
    home.goalsFor += result.homeScore;
    home.goalsAgainst += result.awayScore;
    away.goalsFor += result.awayScore;
    away.goalsAgainst += result.homeScore;

    if (result.homeScore > result.awayScore) {
      home.won++;
      away.lost++;
      home.points += 3;
    } else if (result.homeScore < result.awayScore) {
      away.won++;
      home.lost++;
      away.points += 3;
    } else {
      home.drawn++;
      away.drawn++;
      home.points += 1;
      away.points += 1;
    }
  }

  List<Club> get leagueTable {
    final sorted = List<Club>.from(clubs);
    sorted.sort((a, b) {
      if (b.points != a.points) return b.points.compareTo(a.points);
      return b.goalDifference.compareTo(a.goalDifference);
    });
    return sorted;
  }

  Fixture? get nextFixtureForMyClub {
    if (manager == null) return null;
    for (final f in fixtures) {
      if (!f.isPlayed && (f.homeClubId == manager!.clubId || f.awayClubId == manager!.clubId)) {
        return f;
      }
    }
    return null;
  }

  bool get seasonFinished => fixtures.every((f) => f.isPlayed);

  Future<void> saveCareer() async {
    if (manager == null) return;
    await SaveService.save(
      manager: manager!,
      clubs: clubs,
      players: players,
      fixtures: fixtures,
      currentMatchday: currentMatchday,
    );
  }

  Future<bool> loadCareer() async {
    final data = await SaveService.load();
    if (data == null) return false;
    manager = Manager.fromJson(data['manager']);
    clubs = (data['clubs'] as List).map((c) => Club.fromJson(c)).toList();
    players = (data['players'] as List).map((p) => Player.fromJson(p)).toList();
    fixtures = (data['fixtures'] as List).map((f) => Fixture.fromJson(f)).toList();
    currentMatchday = data['currentMatchday'];
    loaded = true;
    notifyListeners();
    return true;
  }
}
