import 'package:flutter/material.dart';
import '../../data/models/player.dart';
import '../../data/models/enums.dart';
import '../theme/app_theme.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final VoidCallback? onTap;

  const PlayerCard({super.key, required this.player, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppTheme.accent.withOpacity(0.15),
          child: Text(
            positionLabel(player.position),
            style: const TextStyle(color: AppTheme.accent, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(player.name, style: const TextStyle(color: AppTheme.textPrimary)),
        subtitle: Text(
          '${player.age} yo · ${player.nationality}',
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.accentSecondary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            player.overall.toStringAsFixed(0),
            style: const TextStyle(color: AppTheme.accentSecondary, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
