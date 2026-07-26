import 'dart:math';
import 'character.dart';
import 'ability.dart';
import 'character_trait.dart';

class CharacterFactory {
  static final Random _random = Random();

  // 8 Base Characters
  static final List<CharacterData> baseCharacters = [
    CharacterData(
      name: 'Knight',
      characterClass: 'Warrior',
      baseStats: CharacterStats(hp: 120, atk: 45, def: 60, spd: 35),
      description: 'Guerreiro com alta defesa',
    ),
    CharacterData(
      name: 'Archer',
      characterClass: 'Ranger',
      baseStats: CharacterStats(hp: 80, atk: 65, def: 30, spd: 55),
      description: 'Atirador rápido e preciso',
    ),
    CharacterData(
      name: 'Mage',
      characterClass: 'Wizard',
      baseStats: CharacterStats(hp: 70, atk: 75, def: 25, spd: 45),
      description: 'Mágico poderoso',
    ),
    CharacterData(
      name: 'Paladin',
      characterClass: 'Holy Knight',
      baseStats: CharacterStats(hp: 110, atk: 50, def: 65, spd: 40),
      description: 'Guerreiro sagrado',
    ),
    CharacterData(
      name: 'Rogue',
      characterClass: 'Assassin',
      baseStats: CharacterStats(hp: 60, atk: 80, def: 20, spd: 70),
      description: 'Assassino rápido e letal',
    ),
    CharacterData(
      name: 'Berserker',
      characterClass: 'Barbarian',
      baseStats: CharacterStats(hp: 130, atk: 85, def: 40, spd: 50),
      description: 'Guerreiro selvagem',
    ),
    CharacterData(
      name: 'Priest',
      characterClass: 'Healer',
      baseStats: CharacterStats(hp: 90, atk: 35, def: 50, spd: 48),
      description: 'Curador sagrado',
    ),
    CharacterData(
      name: 'Druid',
      characterClass: 'Nature Master',
      baseStats: CharacterStats(hp: 100, atk: 55, def: 45, spd: 52),
      description: 'Mestre da natureza',
    ),
  ];

  // Create a base character
  static Character createBaseCharacter(int index) {
    final data = baseCharacters[index % baseCharacters.length];
    return Character(
      name: data.name,
      maxHealth: data.baseStats.hp,
      attack: data.baseStats.atk,
      defense: data.baseStats.def,
      speed: data.baseStats.spd,
      characterClass: data.characterClass,
      rarity: CharacterRarity.common,
      traits: _generateTraits(1),
      abilities: _generateAbilities(data.characterClass, 2),
    );
  }

  // Merge two characters to create a new one
  static Character fuseCharacters(Character char1, Character char2) {
    final random = _random;
    
    // Combine stats with variation
    final newHP = ((char1.maxHealth + char2.maxHealth) ~/ 2) + random.nextInt(20) - 10;
    final newAtk = ((char1.attack + char2.attack) ~/ 2) + random.nextInt(15) - 7;
    final newDef = ((char1.defense + char2.defense) ~/ 2) + random.nextInt(15) - 7;
    final newSpd = ((char1.speed + char2.speed) ~/ 2) + random.nextInt(15) - 7;

    // Determine new rarity
    final rarityIncrease = random.nextDouble();
    final newRarity = _determineNewRarity(char1.rarity, char2.rarity, rarityIncrease);

    // Generate new name
    final newName = _generateFusedName(char1.name, char2.name);

    // Combine traits
    final newTraits = _generateTraits(newRarity == CharacterRarity.legendary ? 4 : 
                                      newRarity == CharacterRarity.epic ? 3 : 2);

    // Combine abilities
    final combinedAbilities = <Ability>{};
    combinedAbilities.addAll(char1.abilities);
    combinedAbilities.addAll(char2.abilities);
    final newAbilities = combinedAbilities.toList();
    if (newAbilities.length > 5) {
      newAbilities.shuffle();
      newAbilities.removeRange(5, newAbilities.length);
    }

    return Character(
      name: newName,
      level: (char1.level + char2.level) ~/ 2,
      maxHealth: newHP,
      attack: newAtk,
      defense: newDef,
      speed: newSpd,
      characterClass: _generateFusedClass(char1.characterClass, char2.characterClass),
      customVisual: _generateCustomVisual(),
      rarity: newRarity,
      traits: newTraits,
      abilities: newAbilities,
    );
  }

  // Generate random traits based on rarity
  static List<CharacterTrait> _generateTraits(int count) {
    final traits = <CharacterTrait>[];
    const traitEffects = TraitEffect.values;
    
    for (int i = 0; i < count; i++) {
      final effect = traitEffects[_random.nextInt(traitEffects.length)];
      traits.add(CharacterTrait(
        id: 'trait_${DateTime.now().millisecondsSinceEpoch}_$i',
        name: _getTraitName(effect),
        description: _getTraitDescription(effect),
        effect: effect,
        effectValue: _random.nextDouble() * 0.5 + 0.5,
      ));
    }
    
    return traits;
  }

  // Generate random abilities
  static List<Ability> _generateAbilities(String characterClass, int count) {
    final abilities = <Ability>[];
    final relevantAbilities = _getAbilitiesForClass(characterClass);
    
    relevantAbilities.shuffle();
    for (int i = 0; i < count && i < relevantAbilities.length; i++) {
      abilities.add(relevantAbilities[i]);
    }
    
    return abilities;
  }

  // Get abilities relevant to a class
  static List<Ability> _getAbilitiesForClass(String characterClass) {
    final abilities = <Ability>[];
    
    switch (characterClass) {
      case 'Warrior':
      case 'Barbarian':
        abilities.addAll([
          Ability(
            id: 'slash',
            name: 'Slash',
            description: 'Basic slash attack',
            type: AbilityType.physicalAttack,
            target: AbilityTarget.singleEnemy,
            energyCost: 20,
            baseEffectValue: 30,
            effectMultiplier: 1.2,
          ),
          Ability(
            id: 'power_strike',
            name: 'Power Strike',
            description: 'Powerful strike',
            type: AbilityType.physicalAttack,
            target: AbilityTarget.singleEnemy,
            energyCost: 50,
            baseEffectValue: 60,
            effectMultiplier: 1.8,
            cooldownTurns: 1,
          ),
        ]);
        break;
      case 'Ranger':
        abilities.addAll([
          Ability(
            id: 'swift_shot',
            name: 'Swift Shot',
            description: 'Quick ranged attack',
            type: AbilityType.physicalAttack,
            target: AbilityTarget.singleEnemy,
            energyCost: 15,
            baseEffectValue: 25,
            effectMultiplier: 1.3,
          ),
          Ability(
            id: 'multi_shot',
            name: 'Multi Shot',
            description: 'Attack multiple enemies',
            type: AbilityType.physicalAttack,
            target: AbilityTarget.allEnemies,
            energyCost: 60,
            baseEffectValue: 35,
            effectMultiplier: 1.0,
          ),
        ]);
        break;
      case 'Wizard':
        abilities.addAll([
          Ability(
            id: 'fireball',
            name: 'Fireball',
            description: 'Launch a ball of fire',
            type: AbilityType.magicAttack,
            target: AbilityTarget.singleEnemy,
            energyCost: 40,
            baseEffectValue: 50,
            effectMultiplier: 1.5,
            specialEffect: 'burn',
            specialEffectChance: 0.3,
          ),
          Ability(
            id: 'meteor',
            name: 'Meteor',
            description: 'Summon meteors',
            type: AbilityType.magicAttack,
            target: AbilityTarget.allEnemies,
            energyCost: 80,
            baseEffectValue: 45,
            effectMultiplier: 1.2,
            cooldownTurns: 2,
          ),
        ]);
        break;
      case 'Healer':
        abilities.addAll([
          Ability(
            id: 'heal',
            name: 'Heal',
            description: 'Restore health',
            type: AbilityType.heal,
            target: AbilityTarget.singleEnemy,
            energyCost: 35,
            baseEffectValue: 40,
            effectMultiplier: 1.0,
          ),
          Ability(
            id: 'mass_heal',
            name: 'Mass Heal',
            description: 'Heal all allies',
            type: AbilityType.heal,
            target: AbilityTarget.allAllies,
            energyCost: 70,
            baseEffectValue: 30,
            effectMultiplier: 1.0,
            cooldownTurns: 2,
          ),
        ]);
        break;
      case 'Assassin':
        abilities.addAll([
          Ability(
            id: 'backstab',
            name: 'Backstab',
            description: 'Quick deadly strike',
            type: AbilityType.physicalAttack,
            target: AbilityTarget.singleEnemy,
            energyCost: 30,
            baseEffectValue: 55,
            effectMultiplier: 1.6,
            specialEffect: 'critical',
            specialEffectChance: 0.4,
          ),
          Ability(
            id: 'shadow_clone',
            name: 'Shadow Clone',
            description: 'Create a shadow clone',
            type: AbilityType.buff,
            target: AbilityTarget.self,
            energyCost: 50,
            baseEffectValue: 25,
            cooldownTurns: 2,
          ),
        ]);
        break;
      default:
        abilities.addAll([
          Ability(
            id: 'basic_attack',
            name: 'Basic Attack',
            description: 'Basic attack',
            type: AbilityType.physicalAttack,
            target: AbilityTarget.singleEnemy,
            energyCost: 10,
            baseEffectValue: 20,
            effectMultiplier: 1.0,
          ),
        ]);
    }
    
    return abilities;
  }

  // Determine rarity after fusion
  static CharacterRarity _determineNewRarity(
    CharacterRarity rarity1,
    CharacterRarity rarity2,
    double random,
  ) {
    final maxRarity = rarity1.index > rarity2.index ? rarity1 : rarity2;
    
    if (random < 0.3) return maxRarity;
    if (random < 0.6) return CharacterRarity.values[(maxRarity.index + 1).clamp(0, 3)];
    return CharacterRarity.values[(maxRarity.index + 2).clamp(0, 3)];
  }

  // Generate fused name
  static String _generateFusedName(String name1, String name2) {
    final part1 = name1.substring(0, (name1.length / 2).ceil());
    final part2 = name2.substring((name2.length / 2).toInt());
    return part1 + part2;
  }

  // Generate fused class
  static String _generateFusedClass(String class1, String class2) {
    const classList = ['Warrior', 'Ranger', 'Wizard', 'Holy Knight', 'Assassin', 'Barbarian', 'Healer', 'Nature Master'];
    return classList[_random.nextInt(classList.length)];
  }

  // Generate custom visual representation
  static String _generateCustomVisual() {
    const colors = ['🔴', '🔵', '🟢', '⚫', '🟡', '⚪'];
    const symbols = ['⚔️', '🗡️', '🏹', '🔮', '🛡️', '⚡'];
    return '${colors[_random.nextInt(colors.length)]}${symbols[_random.nextInt(symbols.length)]}';
  }

  static String _getTraitName(TraitEffect effect) {
    const names = {
      TraitEffect.healthBoost: 'Robust',
      TraitEffect.attackBoost: 'Aggressive',
      TraitEffect.defenseBoost: 'Sturdy',
      TraitEffect.speedBoost: 'Swift',
      TraitEffect.critChance: 'Lucky',
      TraitEffect.lifeSteal: 'Bloodthirsty',
      TraitEffect.fireResist: 'Heat Resistant',
      TraitEffect.frostResist: 'Frost Resistant',
      TraitEffect.poisonResist: 'Poison Resistant',
      TraitEffect.evasion: 'Evasive',
      TraitEffect.counterAttack: 'Retaliator',
      TraitEffect.energyRegeneation: 'Energetic',
    };
    return names[effect] ?? 'Unknown';
  }

  static String _getTraitDescription(TraitEffect effect) {
    const descriptions = {
      TraitEffect.healthBoost: '+10% Health',
      TraitEffect.attackBoost: '+10% Attack',
      TraitEffect.defenseBoost: '+10% Defense',
      TraitEffect.speedBoost: '+10% Speed',
      TraitEffect.critChance: '+20% Critical Chance',
      TraitEffect.lifeSteal: 'Heal 20% damage dealt',
      TraitEffect.fireResist: '-30% Fire Damage',
      TraitEffect.frostResist: '-30% Frost Damage',
      TraitEffect.poisonResist: '-30% Poison Damage',
      TraitEffect.evasion: '+15% Dodge Chance',
      TraitEffect.counterAttack: 'Counter 30% of attacks',
      TraitEffect.energyRegeneation: '+5% Energy per turn',
    };
    return descriptions[effect] ?? 'Unknown effect';
  }
}

class CharacterData {
  final String name;
  final String characterClass;
  final CharacterStats baseStats;
  final String description;

  CharacterData({
    required this.name,
    required this.characterClass,
    required this.baseStats,
    required this.description,
  });
}

class CharacterStats {
  final int hp;
  final int atk;
  final int def;
  final int spd;

  CharacterStats({
    required this.hp,
    required this.atk,
    required this.def,
    required this.spd,
  });
}
