import 'enums.dart';

class Tactic {
  Formation formation;
  Mentality mentality;
  BuildUp buildUp;
  PressingLevel pressing;
  DefensiveLine defensiveLine;
  Tempo tempo;
  Width width;
  bool counterEnabled;
  bool offsideTrap;

  Tactic({
    this.formation = Formation.f433,
    this.mentality = Mentality.balanced,
    this.buildUp = BuildUp.mixed,
    this.pressing = PressingLevel.medium,
    this.defensiveLine = DefensiveLine.normal,
    this.tempo = Tempo.normal,
    this.width = Width.balanced,
    this.counterEnabled = true,
    this.offsideTrap = false,
  });

  Map<String, dynamic> toJson() => {
        'formation': formation.name,
        'mentality': mentality.name,
        'buildUp': buildUp.name,
        'pressing': pressing.name,
        'defensiveLine': defensiveLine.name,
        'tempo': tempo.name,
        'width': width.name,
        'counterEnabled': counterEnabled,
        'offsideTrap': offsideTrap,
      };

  factory Tactic.fromJson(Map<String, dynamic> json) => Tactic(
        formation: Formation.values.firstWhere((e) => e.name == json['formation']),
        mentality: Mentality.values.firstWhere((e) => e.name == json['mentality']),
        buildUp: BuildUp.values.firstWhere((e) => e.name == json['buildUp']),
        pressing: PressingLevel.values.firstWhere((e) => e.name == json['pressing']),
        defensiveLine: DefensiveLine.values.firstWhere((e) => e.name == json['defensiveLine']),
        tempo: Tempo.values.firstWhere((e) => e.name == json['tempo']),
        width: Width.values.firstWhere((e) => e.name == json['width']),
        counterEnabled: json['counterEnabled'],
        offsideTrap: json['offsideTrap'],
      );
}
