import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/career_state.dart';
import '../../data/models/enums.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_bar.dart';

class PlayerDetailScreen extends StatelessWidget {
  final String playerId;

  const PlayerDetailScreen({super.key, required this.playerId});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CareerState>();
    final player = state.playerById(playerId)!;

    return Scaffold(
      appBar: AppBar(title: Text(player.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppTheme.accent.withOpacity(0.15),
                child: Text(positionLabel(player.position), style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(player.name, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${player.age} yo · ${player.nationality}', style: const TextStyle(color: AppTheme.textSecondary)),
                    Text(personalityLabel(player.personality), style: const TextStyle(color: AppTheme.accentSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(player.overall.toStringAsFixed(0), style: const TextStyle(color: AppTheme.accent, fontSize: 24, fontWeight: FontWeight.bold)),
                  const Text('OVR', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _section('Technical', player.technical),
          _section('Mental', player.mental),
          _section('Physical', player.physical),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _infoCard('Potential', player.potential.toString())),
              const SizedBox(width: 12),
              Expanded(child: _infoCard('Morale', '${player.morale}%')),
              const SizedBox(width: 12),
              Expanded(child: _infoCard('Form', player.form.toString())),
            ],
          ),
        ],
      ),
    );
  }

  Widget _section(String title, Map<String, int> attributes) {
    return Card(
      color: AppTheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...attributes.entries.map((e) => StatBar(label: e.key, value: e.value)),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value) {
    return Card(
      color: AppTheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
            Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
