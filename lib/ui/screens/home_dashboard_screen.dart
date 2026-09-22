import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/career_state.dart';
import '../theme/app_theme.dart';
import 'squad_screen.dart';
import 'tactics_screen.dart';
import 'match_screen.dart';
import 'league_table_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CareerState>();
    final club = state.myClub;
    final nextFixture = state.nextFixtureForMyClub;

    if (club == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppTheme.accent)));
    }

    final squad = state.squadOf(club.id);
    final avgMorale = squad.isEmpty ? 0 : squad.map((p) => p.morale).reduce((a, b) => a + b) / squad.length;
    final position = state.leagueTable.indexWhere((c) => c.id == club.id) + 1;

    String opponentName = '-';
    if (nextFixture != null) {
      final isHome = nextFixture.homeClubId == club.id;
      final oppId = isHome ? nextFixture.awayClubId : nextFixture.homeClubId;
      opponentName = state.clubById(oppId)?.name ?? '-';
    }

    return Scaffold(
      appBar: AppBar(title: Text(club.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Good morning, Manager.', style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 16),
          Card(
            color: AppTheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('NEXT MATCH', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, letterSpacing: 1)),
                  const SizedBox(height: 6),
                  Text(
                    nextFixture == null ? 'Season finished' : '${club.name} vs $opponentName',
                    style: const TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (nextFixture != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MatchScreen()));
                        },
                        child: const Text('Go to Match Day'),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _statCard('League Position', '${position == 0 ? '-' : position}th')),
              const SizedBox(width: 12),
              Expanded(child: _statCard('Morale', '${avgMorale.toStringAsFixed(0)}%')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _statCard('Transfer Budget', '€${(club.transferBudget / 1000).toStringAsFixed(0)}K')),
              const SizedBox(width: 12),
              Expanded(child: _statCard('Wage Budget', '€${(club.wageBudget / 1000).toStringAsFixed(0)}K/wk')),
            ],
          ),
          const SizedBox(height: 24),
          _menuTile(context, Icons.groups, 'Squad', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SquadScreen()))),
          _menuTile(context, Icons.dashboard_customize, 'Tactics', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TacticsScreen()))),
          _menuTile(context, Icons.leaderboard, 'League Table', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeagueTableScreen()))),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value) {
    return Card(
      color: AppTheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Card(
      color: AppTheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accent),
        title: Text(label, style: const TextStyle(color: AppTheme.textPrimary)),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
        onTap: onTap,
      ),
    );
  }
}
