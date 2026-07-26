enum AbilityType {
  physicalAttack,
  magicAttack,
  heal,
  buff,
  debuff,
  ultimate,
}

enum AbilityTarget {
  singleEnemy,
  allEnemies,
  self,
  allAllies,
}

class Ability {
  final String id;
  final String name;
  final String description;
  final AbilityType type;
  final AbilityTarget target;
  
  // Resource cost (energy)
  final int energyCost;
  
  // Damage/Effect values
  final int baseEffectValue;
  final double effectMultiplier;
  
  // Cooldown
  final int cooldownTurns;
  int currentCooldown;
  
  // Special effects
  final String? specialEffect;
  final double specialEffectChance;

  Ability({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.target,
    required this.energyCost,
    required this.baseEffectValue,
    this.effectMultiplier = 1.0,
    this.cooldownTurns = 0,
    this.currentCooldown = 0,
    this.specialEffect,
    this.specialEffectChance = 0.0,
  });

  // Check if ability can be used
  bool get isReady => currentCooldown == 0;

  // Reduce cooldown
  void reduceCooldown() {
    if (currentCooldown > 0) {
      currentCooldown--;
    }
  }

  // Reset cooldown
  void resetCooldown() {
    currentCooldown = cooldownTurns;
  }

  // Copy with modifications
  Ability copyWith({
    int? currentCooldown,
  }) {
    return Ability(
      id: id,
      name: name,
      description: description,
      type: type,
      target: target,
      energyCost: energyCost,
      baseEffectValue: baseEffectValue,
      effectMultiplier: effectMultiplier,
      cooldownTurns: cooldownTurns,
      currentCooldown: currentCooldown ?? this.currentCooldown,
      specialEffect: specialEffect,
      specialEffectChance: specialEffectChance,
    );
  }

  @override
  String toString() => 'Ability($name, Cost: $energyCost)';
}
