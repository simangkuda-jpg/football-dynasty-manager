enum PlayerPosition { gk, cb, lb, rb, cdm, cm, cam, lw, rw, st }

enum PreferredFoot { left, right, both }

enum PlayerPersonality {
  professional,
  leader,
  ambitious,
  loyal,
  mercenary,
  hotHeaded,
  introvert,
  teamPlayer,
  egoistic,
  perfectionist,
  wonderkid,
  veteran,
}

enum Formation { f433, f4231, f442, f352, f343, f532 }

enum Mentality { veryDefensive, defensive, balanced, positive, attacking, veryAttacking }

enum BuildUp { shortPassing, mixed, direct }

enum PressingLevel { low, medium, high, gegenpress }

enum DefensiveLine { deep, normal, high }

enum Tempo { slow, normal, fast }

enum Width { narrow, balanced, wide }

String positionLabel(PlayerPosition p) {
  switch (p) {
    case PlayerPosition.gk:
      return 'GK';
    case PlayerPosition.cb:
      return 'CB';
    case PlayerPosition.lb:
      return 'LB';
    case PlayerPosition.rb:
      return 'RB';
    case PlayerPosition.cdm:
      return 'CDM';
    case PlayerPosition.cm:
      return 'CM';
    case PlayerPosition.cam:
      return 'CAM';
    case PlayerPosition.lw:
      return 'LW';
    case PlayerPosition.rw:
      return 'RW';
    case PlayerPosition.st:
      return 'ST';
  }
}

String formationLabel(Formation f) {
  switch (f) {
    case Formation.f433:
      return '4-3-3';
    case Formation.f4231:
      return '4-2-3-1';
    case Formation.f442:
      return '4-4-2';
    case Formation.f352:
      return '3-5-2';
    case Formation.f343:
      return '3-4-3';
    case Formation.f532:
      return '5-3-2';
  }
}

String mentalityLabel(Mentality m) {
  switch (m) {
    case Mentality.veryDefensive:
      return 'Very Defensive';
    case Mentality.defensive:
      return 'Defensive';
    case Mentality.balanced:
      return 'Balanced';
    case Mentality.positive:
      return 'Positive';
    case Mentality.attacking:
      return 'Attacking';
    case Mentality.veryAttacking:
      return 'Very Attacking';
  }
}

String personalityLabel(PlayerPersonality p) {
  return p.name[0].toUpperCase() + p.name.substring(1);
}
