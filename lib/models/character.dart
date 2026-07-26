import 'package:uuid/uuid.dart';
import 'dart:math';
import 'ability.dart';
import 'character_trait.dart';

enum CharacterRarity { common, rare, epic, legendary }

class Character {
  final String id;
  final String name;
  final int level;
  final int experience;
  
  // Stats
  final int maxHealth;
  final int health;
  final int attack;
  final int defense;
  final int speed;
  
  // Visual & Identity
  final String characterClass;
  final String? customVisual;
  final CharacterRarity rarity;
  final List<CharacterTrait> traits;
  
  // Combat
  final List<Ability> abilities;
  final int resourceEnergy;
  final int maxResourceEnergy;

  Character({
    String? id,
    required this.name,
    this.level = 1,
    this.experience = 0,
    required this.maxHealth,
    int? health,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.characterClass,
    this.customVisual,
    required this.rarity,
    required this.traits,
    required this.abilities,
    int? resourceEnergy,
    this.maxResourceEnergy = 100,
  })  : id = id ?? const Uuid().v4(),
        health = health ?? maxHealth,
        resourceEnergy = resourceEnergy ?? 100;

  // Create a copy with modifications
  Character copyWith({
    String? name,
    int? level,
    int? experience,
    int? maxHealth,
    int? health,
    int? attack,
    int? defense,
    int? speed,
    String? customVisual,
    CharacterRarity? rarity,
    List<CharacterTrait>? traits,
    List<Ability>? abilities,
    int? resourceEnergy,
  }) {
    return Character(
      id: id,
      name: name ?? this.name,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      maxHealth: maxHealth ?? this.maxHealth,
      health: health ?? this.health,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      speed: speed ?? this.speed,
      characterClass: characterClass,
      customVisual: customVisual ?? this.customVisual,
      rarity: rarity ?? this.rarity,
      traits: traits ?? this.traits,
      abilities: abilities ?? this.abilities,
      resourceEnergy: resourceEnergy ?? this.resourceEnergy,
      maxResourceEnergy: maxResourceEnergy,
    );
  }

  // Take damage
  Character takeDamage(int damage) {
    final finalDamage = max(1, damage - (defense ~/ 4));
    final newHealth = max(0, health - finalDamage);
    return copyWith(health: newHealth);
  }

  // Restore health
  Character restoreHealth(int amount) {
    final newHealth = min(maxHealth, health + amount);
    return copyWith(health: newHealth);
  }

  // Add experience
  Character addExperience(int exp) {
    return copyWith(experience: experience + exp);
  }

  // Check if character is alive
  bool get isAlive => health > 0;

  // Get health percentage
  double get healthPercentage => health / maxHealth;

  // Get rarity color
  String get rarityColor {
    switch (rarity) {
      case CharacterRarity.common:
        return '0xFFB0BEC5';
      case CharacterRarity.rare:
        return '0xFF1E88E5';
      case CharacterRarity.epic:
        return '0xFF7E57C2';
      case CharacterRarity.legendary:
        return '0xFFFFD700';
    }
  }

  @override
  String toString() => 'Character($name, Lvl.$level, HP: $health/$maxHealth)';
}
