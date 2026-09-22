import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatBar extends StatelessWidget {
  final String label;
  final int value;
  final int max;

  const StatBar({super.key, required this.label, required this.value, this.max = 20});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value / max,
                minHeight: 8,
                backgroundColor: AppTheme.bg,
                valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 24, child: Text('$value', style: const TextStyle(color: AppTheme.textPrimary, fontSize: 12))),
        ],
      ),
    );
  }
}
