import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/career_state.dart';
import '../../data/models/match_models.dart';
import '../theme/app_theme.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  bool simulated = false;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CareerState>();
    final club = state.myClub!;
    final fixture = state.nextFixtureForMyClub;

    if (fixture == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Match Day')),
        body: const Center(child: Text('No upcoming match', style: TextStyle(color: AppTheme.textSecondary))),
      );
    }

    final isHome = fixture.homeClubId == club.id;
    final opponent = state.clubById(isHome ? fixture.awayClubId : fixture.homeClubId)!;
    final result = fixture.result;

    return Scaffold(
      appBar: AppBar(title: const Text('Match Day')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: AppTheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      isHome ? '${club.name} vs ${opponent.name}' : '${opponent.name} vs ${club.name}',
                      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    if (result == null)
                      const Text('Kick-off pending', style: TextStyle(color: AppTheme.textSecondary))
                    else
                      Text(
                        '${result.homeScore} - ${result.awayScore}',
                        style: const TextStyle(color: AppTheme.accent, fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (result == null)
              ElevatedButton(
                onPressed: () {
                  final matchday = fixture.matchday;
                  while (state.currentMatchday < matchday) {
                    state.simulateMatchday();
                  }
                  state.simulateMatchday();
                  state.saveCareer();
                  setState(() => simulated = true);
                },
                child: const Text('Simulate Match'),
              ),
            if (result != null)
              Expanded(
                child: ListView(
                  children: [
                    _statRow('Possession', '${result.homePossession.toStringAsFixed(0)}%', '${result.awayPossession.toStringAsFixed(0)}%'),
                    _statRow('Shots', '${result.homeShots}', '${result.awayShots}'),
                    _statRow('Shots on Target', '${result.homeShotsOnTarget}', '${result.awayShotsOnTarget}'),
                    const SizedBox(height: 16),
                    const Text('EVENTS', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, letterSpacing: 1)),
                    const SizedBox(height: 8),
                    ...result.events.map((e) => _eventTile(e)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String home, String away) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(home, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textPrimary))),
          Expanded(child: Text(label, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11))),
          Expanded(child: Text(away, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textPrimary))),
        ],
      ),
    );
  }

  Widget _eventTile(MatchEvent event) {
    IconData icon;
    switch (event.type) {
      case 'goal':
        icon = Icons.sports_soccer;
        break;
      case 'card':
        icon = Icons.square;
        break;
      default:
        icon = Icons.shield_moon;
    }
    return ListTile(
      dense: true,
      leading: Icon(icon, color: AppTheme.accent, size: 18),
      title: Text(event.description, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13)),
      trailing: Text("${event.minute}'", style: const TextStyle(color: AppTheme.textSecondary)),
    );
  }
}
