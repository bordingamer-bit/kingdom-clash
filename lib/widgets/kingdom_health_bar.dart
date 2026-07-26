import 'package:flutter/material.dart';
import '../models/kingdom.dart';

class KingdomHealthBar extends StatelessWidget {
  final Kingdom kingdom;
  final bool isPlayer;

  const KingdomHealthBar({
    Key? key,
    required this.kingdom,
    this.isPlayer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border.all(
          color: isPlayer ? const Color(0xFF1E88E5) : const Color(0xFFB71C1C),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kingdom.name,
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${kingdom.health}/${kingdom.maxHealth}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: kingdom.healthPercentage,
              minHeight: 24,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(
                kingdom.health > kingdom.maxHealth * 0.5
                    ? Colors.green
                    : kingdom.health > kingdom.maxHealth * 0.25
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Active Team: ${kingdom.aliveTeam.length}/${kingdom.activeTeam.length} alive',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
