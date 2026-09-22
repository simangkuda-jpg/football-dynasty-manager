import 'dart:math';
import '../data/models/club.dart';
import '../data/models/player.dart';
import '../data/models/match_models.dart';
import '../data/models/enums.dart';

class MatchEngine {
  static MatchResult simulate({
    required String matchId,
    required Club homeClub,
    required Club awayClub,
    required List<Player> homePlayers,
    required List<Player> awayPlayers,
  }) {
    final seed = matchId.hashCode;
    final rng = Random(seed);

    final homeAttack = _teamStrength(homePlayers, ['finishing', 'longShots', 'dribbling', 'crossing'], ['pace', 'acceleration']);
    final homeMid = _teamStrength(homePlayers, ['passing', 'vision', 'decisions', 'teamwork'], ['stamina']);
    final homeDef = _teamStrength(homePlayers, ['tackling', 'marking', 'heading'], ['strength', 'agility']);

    final awayAttack = _teamStrength(awayPlayers, ['finishing', 'longShots', 'dribbling', 'crossing'], ['pace', 'acceleration']);
    final awayMid = _teamStrength(awayPlayers, ['passing', 'vision', 'decisions', 'teamwork'], ['stamina']);
    final awayDef = _teamStrength(awayPlayers, ['tackling', 'marking', 'heading'], ['strength', 'agility']);

    final homeMentalityBoost = _mentalityAttackFactor(homeClub.tactic.mentality);
    final awayMentalityBoost = _mentalityAttackFactor(awayClub.tactic.mentality);

    final homeOverall = (homeAttack * homeMentalityBoost + homeMid + homeDef) / 3 + 3;
    final awayOverall = (awayAttack * awayMentalityBoost + awayMid + awayDef) / 3;

    final strengthGap = homeOverall - awayOverall;
    final homePossessionBase = 50 + strengthGap * 1.6;
    final homePossession = homePossessionBase.clamp(30, 70).toDouble();
    final awayPossession = 100 - homePossession;

    int homeScore = 0;
    int awayScore = 0;
    int homeShots = 0;
    int awayShots = 0;
    int homeShotsOnTarget = 0;
    int awayShotsOnTarget = 0;
    final events = <MatchEvent>[];

    for (int minute = 3; minute <= 90; minute += rng.nextInt(5) + 3) {
      final chanceRoll = rng.nextDouble();
      final homeChanceProb = 0.5 + (homeAttack - awayDef) / 200 + (homePossession - 50) / 400;
      final isHomeChance = chanceRoll < homeChanceProb.clamp(0.15, 0.85);

      final attackStrength = isHomeChance ? homeAttack : awayAttack;
      final defenseStrength = isHomeChance ? awayDef : homeDef;

      final shotRoll = rng.nextDouble();
      if (shotRoll < 0.45) {
        if (isHomeChance) {
          homeShots++;
        } else {
          awayShots++;
        }

        final onTargetRoll = rng.nextDouble();
        final onTargetProb = 0.4 + (attackStrength - defenseStrength) / 150;
        if (onTargetRoll < onTargetProb.clamp(0.2, 0.75)) {
          if (isHomeChance) {
            homeShotsOnTarget++;
          } else {
            awayShotsOnTarget++;
          }

          final goalRoll = rng.nextDouble();
          final goalProb = 0.28 + (attackStrength - defenseStrength) / 180;
          if (goalRoll < goalProb.clamp(0.08, 0.6)) {
            if (isHomeChance) {
              homeScore++;
              events.add(MatchEvent(minute: minute, type: 'goal', description: '${homeClub.name} scores!'));
            } else {
              awayScore++;
              events.add(MatchEvent(minute: minute, type: 'goal', description: '${awayClub.name} scores!'));
            }
          } else {
            events.add(MatchEvent(
              minute: minute,
              type: 'save',
              description: isHomeChance ? 'Big chance for ${homeClub.name}, saved!' : 'Big chance for ${awayClub.name}, saved!',
            ));
          }
        }
      }

      if (rng.nextDouble() < 0.02) {
        events.add(MatchEvent(
          minute: minute,
          type: 'card',
          description: isHomeChance ? 'Yellow card for ${awayClub.name}' : 'Yellow card for ${homeClub.name}',
        ));
      }
    }

    events.sort((a, b) => a.minute.compareTo(b.minute));

    return MatchResult(
      id: matchId,
      homeClubId: homeClub.id,
      awayClubId: awayClub.id,
      homeScore: homeScore,
      awayScore: awayScore,
      homePossession: homePossession,
      awayPossession: awayPossession,
      homeShots: homeShots,
      awayShots: awayShots,
      homeShotsOnTarget: homeShotsOnTarget,
      awayShotsOnTarget: awayShotsOnTarget,
      events: events,
    );
  }

  static double _teamStrength(List<Player> players, List<String> technicalKeys, List<String> physicalKeys) {
    if (players.isEmpty) return 10;
    double total = 0;
    int count = 0;
    for (final p in players) {
      for (final key in technicalKeys) {
        if (p.technical.containsKey(key)) {
          total += p.technical[key]!;
          count++;
        }
        if (p.mental.containsKey(key)) {
          total += p.mental[key]!;
          count++;
        }
      }
      for (final key in physicalKeys) {
        if (p.physical.containsKey(key)) {
          total += p.physical[key]!;
          count++;
        }
      }
      total += p.form * 0.3;
      count++;
    }
    return count == 0 ? 10 : total / count;
  }

  static double _mentalityAttackFactor(Mentality m) {
    switch (m) {
      case Mentality.veryDefensive:
        return 0.8;
      case Mentality.defensive:
        return 0.9;
      case Mentality.balanced:
        return 1.0;
      case Mentality.positive:
        return 1.08;
      case Mentality.attacking:
        return 1.15;
      case Mentality.veryAttacking:
        return 1.25;
    }
  }
}
