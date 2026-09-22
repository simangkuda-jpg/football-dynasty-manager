import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/career_state.dart';
import '../theme/app_theme.dart';
import '../widgets/player_card.dart';
import 'player_detail_screen.dart';

class SquadScreen extends StatelessWidget {
  const SquadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CareerState>();
    final club = state.myClub!;
    final squad = state.squadOf(club.id)..sort((a, b) => b.overall.compareTo(a.overall));

    return Scaffold(
      appBar: AppBar(title: const Text('Squad')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: squad.length,
        itemBuilder: (context, index) {
          final player = squad[index];
          return PlayerCard(
            player: player,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PlayerDetailScreen(playerId: player.id)),
              );
            },
          );
        },
      ),
    );
  }
}
