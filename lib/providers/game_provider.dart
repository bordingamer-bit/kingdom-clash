import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../models/character_factory.dart';
import '../models/kingdom.dart';

class GameProvider extends ChangeNotifier {
  late Kingdom playerKingdom;
  late Kingdom enemyKingdom;
  List<Character> baseCharacters = [];
  bool gameInitialized = false;

  GameProvider() {
    initializeGame();
  }

  // Initialize game with 8 base characters
  void initializeGame() {
    playerKingdom = Kingdom(name: 'Your Kingdom');
    enemyKingdom = Kingdom(name: 'Enemy Kingdom');
    
    baseCharacters = List.generate(
      8,
      (index) => CharacterFactory.createBaseCharacter(index),
    );
    
    // Add base characters to player roster
    for (var char in baseCharacters) {
      playerKingdom.addCharacter(char);
    }
    
    // Add characters to enemy roster
    for (var char in baseCharacters) {
      enemyKingdom.addCharacter(char.copyWith(
        name: '${char.name} (Enemy)',
      ));
    }
    
    gameInitialized = true;
    notifyListeners();
  }

  // Fuse two characters
  Character fuseCharacters(Character char1, Character char2) {
    final newCharacter = CharacterFactory.fuseCharacters(char1, char2);
    
    // Remove originals and add fused
    playerKingdom.removeCharacter(char1.id);
    playerKingdom.removeCharacter(char2.id);
    playerKingdom.addCharacter(newCharacter);
    
    notifyListeners();
    return newCharacter;
  }

  // Set player active team
  void setPlayerTeam(List<Character> team) {
    playerKingdom.setActiveTeam(team);
    notifyListeners();
  }

  // Set enemy active team
  void setEnemyTeam(List<Character> team) {
    enemyKingdom.setActiveTeam(team);
    notifyListeners();
  }

  // Get player roster
  List<Character> getPlayerRoster() => playerKingdom.roster;

  // Get enemy roster
  List<Character> getEnemyRoster() => enemyKingdom.roster;

  // Reset game
  void resetGame() {
    initializeGame();
  }

  // Add gold to player
  void addGold(int amount) {
    playerKingdom.gold += amount;
    notifyListeners();
  }

  // Deduct gold from player
  bool deductGold(int amount) {
    if (playerKingdom.gold >= amount) {
      playerKingdom.gold -= amount;
      notifyListeners();
      return true;
    }
    return false;
  }
}
