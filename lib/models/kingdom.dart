import 'package:uuid/uuid.dart';
import 'character.dart';

class Kingdom {
  final String id;
  final String name;
  int gold;
  int health;
  final int maxHealth;
  final List<Character> roster;
  final List<Character> activeTeam;

  Kingdom({
    String? id,
    required this.name,
    this.gold = 1000,
    int? health,
    this.maxHealth = 1000,
    List<Character>? roster,
    List<Character>? activeTeam,
  })  : id = id ?? const Uuid().v4(),
        health = health ?? maxHealth,
        roster = roster ?? [],
        activeTeam = activeTeam ?? [];

  // Add character to roster
  void addCharacter(Character character) {
    roster.add(character);
  }

  // Remove character from roster
  bool removeCharacter(String characterId) {
    return roster.removeWhere((c) => c.id == characterId) > 0;
  }

  // Set active team (max 3 characters)
  void setActiveTeam(List<Character> team) {
    if (team.length <= 3) {
      activeTeam.clear();
      activeTeam.addAll(team);
    }
  }

  // Take damage to kingdom
  void takeDamage(int damage) {
    health = (health - damage).clamp(0, maxHealth);
  }

  // Restore health
  void restoreHealth(int amount) {
    health = (health + amount).clamp(0, maxHealth);
  }

  // Check if kingdom is defeated
  bool get isDefeated => health <= 0;

  // Get health percentage
  double get healthPercentage => health / maxHealth;

  // Get active team that is alive
  List<Character> get aliveTeam => activeTeam.where((c) => c.isAlive).toList();

  @override
  String toString() => 'Kingdom($name, HP: $health/$maxHealth, Roster: ${roster.length})';
}
