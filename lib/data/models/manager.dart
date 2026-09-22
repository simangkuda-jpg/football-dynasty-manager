class Manager {
  final String id;
  String name;
  String nationality;
  String clubId;
  int leadership;
  int tacticalKnowledge;
  int motivation;
  int negotiation;
  int mediaHandling;
  int reputation;

  Manager({
    required this.id,
    required this.name,
    required this.nationality,
    required this.clubId,
    this.leadership = 10,
    this.tacticalKnowledge = 10,
    this.motivation = 10,
    this.negotiation = 10,
    this.mediaHandling = 10,
    this.reputation = 1,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nationality': nationality,
        'clubId': clubId,
        'leadership': leadership,
        'tacticalKnowledge': tacticalKnowledge,
        'motivation': motivation,
        'negotiation': negotiation,
        'mediaHandling': mediaHandling,
        'reputation': reputation,
      };

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json['id'],
        name: json['name'],
        nationality: json['nationality'],
        clubId: json['clubId'],
        leadership: json['leadership'],
        tacticalKnowledge: json['tacticalKnowledge'],
        motivation: json['motivation'],
        negotiation: json['negotiation'],
        mediaHandling: json['mediaHandling'],
        reputation: json['reputation'],
      );
}
