import 'tactic.dart';

class Club {
  final String id;
  String name;
  String leagueId;
  int reputation;
  double financeBalance;
  double wageBudget;
  double transferBudget;
  List<String> squadPlayerIds;
  Tactic tactic;
  int points;
  int played;
  int won;
  int drawn;
  int lost;
  int goalsFor;
  int goalsAgainst;

  Club({
    required this.id,
    required this.name,
    required this.leagueId,
    required this.reputation,
    required this.financeBalance,
    required this.wageBudget,
    required this.transferBudget,
    required this.squadPlayerIds,
    required this.tactic,
    this.points = 0,
    this.played = 0,
    this.won = 0,
    this.drawn = 0,
    this.lost = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
  });

  int get goalDifference => goalsFor - goalsAgainst;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'leagueId': leagueId,
        'reputation': reputation,
        'financeBalance': financeBalance,
        'wageBudget': wageBudget,
        'transferBudget': transferBudget,
        'squadPlayerIds': squadPlayerIds,
        'tactic': tactic.toJson(),
        'points': points,
        'played': played,
        'won': won,
        'drawn': drawn,
        'lost': lost,
        'goalsFor': goalsFor,
        'goalsAgainst': goalsAgainst,
      };

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json['id'],
        name: json['name'],
        leagueId: json['leagueId'],
        reputation: json['reputation'],
        financeBalance: (json['financeBalance'] as num).toDouble(),
        wageBudget: (json['wageBudget'] as num).toDouble(),
        transferBudget: (json['transferBudget'] as num).toDouble(),
        squadPlayerIds: List<String>.from(json['squadPlayerIds']),
        tactic: Tactic.fromJson(json['tactic']),
        points: json['points'],
        played: json['played'],
        won: json['won'],
        drawn: json['drawn'],
        lost: json['lost'],
        goalsFor: json['goalsFor'],
        goalsAgainst: json['goalsAgainst'],
      );
}
