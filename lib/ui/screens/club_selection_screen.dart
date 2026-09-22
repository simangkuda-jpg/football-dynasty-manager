import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/seed/seed_data.dart';
import '../../state/career_state.dart';
import '../theme/app_theme.dart';
import 'home_dashboard_screen.dart';

class ClubSelectionScreen extends StatelessWidget {
  final String managerName;
  final String managerNationality;

  const ClubSelectionScreen({super.key, required this.managerName, required this.managerNationality});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Club')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: SeedData.clubNames.length,
        itemBuilder: (context, index) {
          final name = SeedData.clubNames[index];
          return Card(
            color: AppTheme.surface,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppTheme.accent,
                child: Icon(Icons.shield, color: Colors.black),
              ),
              title: Text(name, style: const TextStyle(color: AppTheme.textPrimary)),
              trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
              onTap: () {
                final state = context.read<CareerState>();
                state.startNewCareer(
                  managerName: managerName,
                  managerNationality: managerNationality,
                  chosenClubId: 'club_$index',
                );
                state.saveCareer();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeDashboardScreen()),
                  (route) => false,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
