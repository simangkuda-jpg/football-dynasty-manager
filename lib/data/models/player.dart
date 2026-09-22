import 'enums.dart';

class Player {
  final String id;
  String name;
  int age;
  String nationality;
  PlayerPosition position;
  PreferredFoot preferredFoot;
  String clubId;

  Map<String, int> technical;
  Map<String, int> mental;
  Map<String, int> physical;

  int potential;
  int consistency;
  int injuryRisk;
  int professionalism;
  PlayerPersonality personality;
  int form;
  int morale;
  double value;
  double wage;

  Player({
    required this.id,
    required this.name,
    required this.age,
    required this.nationality,
    required this.position,
    required this.preferredFoot,
    required this.clubId,
    required this.technical,
    required this.mental,
    required this.physical,
    required this.potential,
    required this.consistency,
    required this.injuryRisk,
    required this.professionalism,
    required this.personality,
    required this.form,
    required this.morale,
    required this.value,
    required this.wage,
  });

  double get overall {
    final all = [...technical.values, ...mental.values, ...physical.values];
    return all.reduce((a, b) => a + b) / all.length;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'nationality': nationality,
        'position': position.name,
        'preferredFoot': preferredFoot.name,
        'clubId': clubId,
        'technical': technical,
        'mental': mental,
        'physical': physical,
        'potential': potential,
        'consistency': consistency,
        'injuryRisk': injuryRisk,
        'professionalism': professionalism,
        'personality': personality.name,
        'form': form,
        'morale': morale,
        'value': value,
        'wage': wage,
      };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        nationality: json['nationality'],
        position: PlayerPosition.values.firstWhere((e) => e.name == json['position']),
        preferredFoot: PreferredFoot.values.firstWhere((e) => e.name == json['preferredFoot']),
        clubId: json['clubId'],
        technical: Map<String, int>.from(json['technical']),
        mental: Map<String, int>.from(json['mental']),
        physical: Map<String, int>.from(json['physical']),
        potential: json['potential'],
        consistency: json['consistency'],
        injuryRisk: json['injuryRisk'],
        professionalism: json['professionalism'],
        personality: PlayerPersonality.values.firstWhere((e) => e.name == json['personality']),
        form: json['form'],
        morale: json['morale'],
        value: (json['value'] as num).toDouble(),
        wage: (json['wage'] as num).toDouble(),
      );
}
