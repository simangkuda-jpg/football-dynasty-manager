class MatchEvent {
  final int minute;
  final String type;
  final String description;

  MatchEvent({required this.minute, required this.type, required this.description});

  Map<String, dynamic> toJson() => {'minute': minute, 'type': type, 'description': description};

  factory MatchEvent.fromJson(Map<String, dynamic> json) =>
      MatchEvent(minute: json['minute'], type: json['type'], description: json['description']);
}

class MatchResult {
  final String id;
  final String homeClubId;
  final String awayClubId;
  final int homeScore;
  final int awayScore;
  final double homePossession;
  final double awayPossession;
  final int homeShots;
  final int awayShots;
  final int homeShotsOnTarget;
  final int awayShotsOnTarget;
  final List<MatchEvent> events;

  MatchResult({
    required this.id,
    required this.homeClubId,
    required this.awayClubId,
    required this.homeScore,
    required this.awayScore,
    required this.homePossession,
    required this.awayPossession,
    required this.homeShots,
    required this.awayShots,
    required this.homeShotsOnTarget,
    required this.awayShotsOnTarget,
    required this.events,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'homeClubId': homeClubId,
        'awayClubId': awayClubId,
        'homeScore': homeScore,
        'awayScore': awayScore,
        'homePossession': homePossession,
        'awayPossession': awayPossession,
        'homeShots': homeShots,
        'awayShots': awayShots,
        'homeShotsOnTarget': homeShotsOnTarget,
        'awayShotsOnTarget': awayShotsOnTarget,
        'events': events.map((e) => e.toJson()).toList(),
      };

  factory MatchResult.fromJson(Map<String, dynamic> json) => MatchResult(
        id: json['id'],
        homeClubId: json['homeClubId'],
        awayClubId: json['awayClubId'],
        homeScore: json['homeScore'],
        awayScore: json['awayScore'],
        homePossession: (json['homePossession'] as num).toDouble(),
        awayPossession: (json['awayPossession'] as num).toDouble(),
        homeShots: json['homeShots'],
        awayShots: json['awayShots'],
        homeShotsOnTarget: json['homeShotsOnTarget'],
        awayShotsOnTarget: json['awayShotsOnTarget'],
        events: (json['events'] as List).map((e) => MatchEvent.fromJson(e)).toList(),
      );
}

class Fixture {
  final String id;
  final String homeClubId;
  final String awayClubId;
  final int matchday;
  MatchResult? result;

  Fixture({
    required this.id,
    required this.homeClubId,
    required this.awayClubId,
    required this.matchday,
    this.result,
  });

  bool get isPlayed => result != null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'homeClubId': homeClubId,
        'awayClubId': awayClubId,
        'matchday': matchday,
        'result': result?.toJson(),
      };

  factory Fixture.fromJson(Map<String, dynamic> json) => Fixture(
        id: json['id'],
        homeClubId: json['homeClubId'],
        awayClubId: json['awayClubId'],
        matchday: json['matchday'],
        result: json['result'] == null ? null : MatchResult.fromJson(json['result']),
      );
}
