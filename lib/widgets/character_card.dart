import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;
  final bool showStats;
  final bool isSelected;

  const CharacterCard({
    Key? key,
    required this.character,
    this.onTap,
    this.showStats = true,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFFFD700) : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF2A2A2A),
        ),
        child: Column(
          children: [
            // Character Visual
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(int.parse(character.rarityColor)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Center(
                child: Text(
                  character.customVisual ?? '⚔️',
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Rarity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          character.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFFFFD700),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getRarityColor(character.rarity),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _getRarityName(character.rarity),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Level
                  Text(
                    'Lvl. ${character.level}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  
                  if (showStats) ...[
                    const SizedBox(height: 6),
                    
                    // Health Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: character.healthPercentage,
                        minHeight: 6,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          character.health > character.maxHealth * 0.25
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                    
                    Text(
                      '${character.health}/${character.maxHealth}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Stats Grid
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.2,
                      children: [
                        _StatBox(label: 'ATK', value: character.attack.toString()),
                        _StatBox(label: 'DEF', value: character.defense.toString()),
                        _StatBox(label: 'SPD', value: character.speed.toString()),
                        _StatBox(label: 'LVL', value: character.level.toString()),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRarityColor(CharacterRarity rarity) {
    switch (rarity) {
      case CharacterRarity.common:
        return Colors.grey;
      case CharacterRarity.rare:
        return Colors.blue;
      case CharacterRarity.epic:
        return Colors.purple;
      case CharacterRarity.legendary:
        return Colors.amber;
    }
  }

  String _getRarityName(CharacterRarity rarity) {
    switch (rarity) {
      case CharacterRarity.common:
        return 'Common';
      case CharacterRarity.rare:
        return 'Rare';
      case CharacterRarity.epic:
        return 'Epic';
      case CharacterRarity.legendary:
        return 'Legendary';
    }
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[700]!, width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFD700),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
