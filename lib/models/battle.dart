import 'dart:math';
import 'character.dart';
import 'ability.dart';

enum BattleState {
  waiting,
  playerTurn,
  enemyTurn,
  playerVictory,
  enemyVictory,
  battleEnd,
}

class BattleAction {
  final Character actor;
  final Character target;
  final Ability ability;
  final int damageDealt;
  final String actionType;

  BattleAction({
    required this.actor,
    required this.target,
    required this.ability,
    required this.damageDealt,
    required this.actionType,
  });
}

class Battle {
  final List<Character> playerTeam;
  final List<Character> enemyTeam;
  
  BattleState state;
  int currentRound;
  List<BattleAction> battleLog;
  
  Character? activePlayerChar;
  Character? activeEnemyChar;

  Battle({
    required this.playerTeam,
    required this.enemyTeam,
  })  : state = BattleState.waiting,
        currentRound = 1,
        battleLog = [],
        activePlayerChar = playerTeam.isNotEmpty ? playerTeam.first : null,
        activeEnemyChar = enemyTeam.isNotEmpty ? enemyTeam.first : null;

  // Execute player action
  void executePlayerAction(Ability ability) {
    if (activePlayerChar == null || activeEnemyChar == null) return;

    final damage = _calculateDamage(activePlayerChar!, activeEnemyChar!, ability);
    
    // Update enemy character
    activeEnemyChar = activeEnemyChar!.takeDamage(damage);
    
    // Log action
    battleLog.add(BattleAction(
      actor: activePlayerChar!,
      target: activeEnemyChar!,
      ability: ability,
      damageDealt: damage,
      actionType: 'playerAttack',
    ));

    // Check if enemy team is defeated
    if (activeEnemyChar!.health <= 0) {
      _switchActiveEnemy();
    }

    if (isEnemyTeamDefeated) {
      state = BattleState.playerVictory;
    } else {
      state = BattleState.enemyTurn;
    }
  }

  // Execute AI action
  void executeAIAction() {
    if (activePlayerChar == null || activeEnemyChar == null) return;

    // Simple AI: select random ability
    final randomAbility = activeEnemyChar!.abilities[
        Random().nextInt(activeEnemyChar!.abilities.length)
    ];
    
    final damage = _calculateDamage(activeEnemyChar!, activePlayerChar!, randomAbility);
    
    // Update player character
    activePlayerChar = activePlayerChar!.takeDamage(damage);
    
    // Log action
    battleLog.add(BattleAction(
      actor: activeEnemyChar!,
      target: activePlayerChar!,
      ability: randomAbility,
      damageDealt: damage,
      actionType: 'enemyAttack',
    ));

    // Check if player team is defeated
    if (activePlayerChar!.health <= 0) {
      _switchActivePlayer();
    }

    if (isPlayerTeamDefeated) {
      state = BattleState.enemyVictory;
    } else {
      state = BattleState.playerTurn;
      currentRound++;
    }
  }

  // Calculate damage based on ability and stats
  int _calculateDamage(Character attacker, Character defender, Ability ability) {
    final baseValue = ability.baseEffectValue;
    final multiplier = ability.effectMultiplier;
    final attackerMod = attacker.attack / 50;
    final defenderMod = defender.defense / 50;
    
    final damage = ((baseValue * multiplier * attackerMod) / defenderMod).toInt();
    
    // Add random variance
    final variance = Random().nextInt((damage * 0.2).toInt()) - (damage * 0.1).toInt();
    
    return max(1, damage + variance);
  }

  // Switch to next alive player character
  void _switchActivePlayer() {
    final aliveChars = playerTeam.where((c) => c.isAlive).toList();
    if (aliveChars.isNotEmpty) {
      activePlayerChar = aliveChars.first;
    }
  }

  // Switch to next alive enemy character
  void _switchActiveEnemy() {
    final aliveChars = enemyTeam.where((c) => c.isAlive).toList();
    if (aliveChars.isNotEmpty) {
      activeEnemyChar = aliveChars.first;
    }
  }

  // Check if player team is defeated
  bool get isPlayerTeamDefeated => playerTeam.every((c) => !c.isAlive);

  // Check if enemy team is defeated
  bool get isEnemyTeamDefeated => enemyTeam.every((c) => !c.isAlive);

  // Get battle result
  String get battleResult {
    if (state == BattleState.playerVictory) return 'Victory!';
    if (state == BattleState.enemyVictory) return 'Defeat!';
    return 'Battle in progress';
  }
}
