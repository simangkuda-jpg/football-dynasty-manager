import 'dart:math';
import '../models/club.dart';
import '../models/player.dart';
import '../models/tactic.dart';
import '../models/enums.dart';

class SeedResult {
  final List<Club> clubs;
  final List<Player> players;
  SeedResult(this.clubs, this.players);
}

class SeedData {
  static const clubNames = [
    'Jakarta FC',
    'Bandung United',
    'Surabaya City',
    'Medan Warriors',
    'Makassar Rovers',
    'Semarang Athletic',
    'Palembang Steel',
    'Bali Coastal',
    'Yogyakarta Kings',
    'Malang Titans',
  ];

  static const nationalities = ['Indonesia', 'Brazil', 'Argentina', 'Portugal', 'Netherlands', 'Nigeria', 'Japan', 'South Korea', 'Croatia', 'Ivory Coast'];

  static const firstNames = ['Rizky', 'Dimas', 'Fajar', 'Andre', 'Bayu', 'Fikri', 'Reza', 'Wahyu', 'Gilang', 'Arif', 'Bruno', 'Carlos', 'Diego', 'Kenji', 'Yusuf', 'Ahmad', 'Putra', 'Farhan'];
  static const lastNames = ['Pratama', 'Saputra', 'Nugroho', 'Wijaya', 'Santoso', 'Hidayat', 'Ramadhan', 'Silva', 'Costa', 'Santos', 'Almeida', 'Kurniawan', 'Firmansyah'];

  static SeedResult generate({int seed = 42}) {
    final rng = Random(seed);
    final clubs = <Club>[];
    final players = <Player>[];

    for (int i = 0; i < clubNames.length; i++) {
      final clubId = 'club_$i';
      final reputation = 40 + rng.nextInt(50);
      final squadIds = <String>[];

      final positionPlan = [
        PlayerPosition.gk, PlayerPosition.gk,
        PlayerPosition.cb, PlayerPosition.cb, PlayerPosition.cb,
        PlayerPosition.lb, PlayerPosition.lb,
        PlayerPosition.rb, PlayerPosition.rb,
        PlayerPosition.cdm, PlayerPosition.cdm,
        PlayerPosition.cm, PlayerPosition.cm, PlayerPosition.cm,
        PlayerPosition.cam, PlayerPosition.cam,
        PlayerPosition.lw, PlayerPosition.rw,
        PlayerPosition.st, PlayerPosition.st,
      ];

      for (int j = 0; j < positionPlan.length; j++) {
        final playerId = 'player_${i}_$j';
        final player = _generatePlayer(rng, playerId, clubId, positionPlan[j], reputation);
        players.add(player);
        squadIds.add(playerId);
      }

      clubs.add(Club(
        id: clubId,
        name: clubNames[i],
        leagueId: 'league_main',
        reputation: reputation,
        financeBalance: 500000 + rng.nextInt(2000000),
        wageBudget: 50000 + rng.nextInt(150000),
        transferBudget: 500000 + rng.nextInt(5000000),
        squadPlayerIds: squadIds,
        tactic: Tactic(),
      ));
    }

    return SeedResult(clubs, players);
  }

  static Player _generatePlayer(Random rng, String id, String clubId, PlayerPosition position, int clubReputation) {
    final base = (clubReputation * 0.15 + 6).clamp(6, 17).toInt();
    int attr() => (base + rng.nextInt(6) - 2).clamp(3, 20);

    final technical = <String, int>{
      'passing': attr(),
      'crossing': attr(),
      'finishing': attr(),
      'dribbling': attr(),
      'firstTouch': attr(),
      'tackling': attr(),
      'marking': attr(),
      'longShots': attr(),
      'heading': attr(),
      'technique': attr(),
    };

    final mental = <String, int>{
      'decisions': attr(),
      'vision': attr(),
      'composure': attr(),
      'concentration': attr(),
      'leadership': attr(),
      'determination': attr(),
      'teamwork': attr(),
      'workRate': attr(),
      'positioning': attr(),
    };

    final physical = <String, int>{
      'pace': attr(),
      'acceleration': attr(),
      'stamina': attr(),
      'strength': attr(),
      'agility': attr(),
      'balance': attr(),
    };

    final age = 17 + rng.nextInt(19);
    final potential = (base + rng.nextInt(8)).clamp(base, 20);
    final name = '${firstNames[rng.nextInt(firstNames.length)]} ${lastNames[rng.nextInt(lastNames.length)]}';

    return Player(
      id: id,
      name: name,
      age: age,
      nationality: nationalities[rng.nextInt(nationalities.length)],
      position: position,
      preferredFoot: PreferredFoot.values[rng.nextInt(PreferredFoot.values.length)],
      clubId: clubId,
      technical: technical,
      mental: mental,
      physical: physical,
      potential: potential,
      consistency: 5 + rng.nextInt(15),
      injuryRisk: rng.nextInt(20),
      professionalism: 5 + rng.nextInt(15),
      personality: PlayerPersonality.values[rng.nextInt(PlayerPersonality.values.length)],
      form: 10 + rng.nextInt(6),
      morale: 60 + rng.nextInt(35),
      value: (base * 40000).toDouble(),
      wage: (base * 800).toDouble(),
    );
  }
}
