enum TraitEffect {
  healthBoost,
  attackBoost,
  defenseBoost,
  speedBoost,
  critChance,
  lifeSteal,
  fireResist,
  frostResist,
  poisonResist,
  evasion,
  counterAttack,
  energyRegeneation,
}

class CharacterTrait {
  final String id;
  final String name;
  final String description;
  final TraitEffect effect;
  final double effectValue;
  final bool isPassive;

  CharacterTrait({
    required this.id,
    required this.name,
    required this.description,
    required this.effect,
    required this.effectValue,
    this.isPassive = true,
  });

  @override
  String toString() => 'Trait($name)';
}
