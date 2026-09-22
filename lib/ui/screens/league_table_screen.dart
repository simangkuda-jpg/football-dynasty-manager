import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/career_state.dart';
import '../theme/app_theme.dart';

class LeagueTableScreen extends StatelessWidget {
  const LeagueTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CareerState>();
    final table = state.leagueTable;
    final myClubId = state.myClub?.id;

    return Scaffold(
      appBar: AppBar(title: const Text('League Table')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppTheme.surface),
          columns: const [
            DataColumn(label: Text('#')),
            DataColumn(label: Text('Club')),
            DataColumn(label: Text('P')),
            DataColumn(label: Text('W')),
            DataColumn(label: Text('D')),
            DataColumn(label: Text('L')),
            DataColumn(label: Text('GD')),
            DataColumn(label: Text('Pts')),
          ],
          rows: table.asMap().entries.map((entry) {
            final index = entry.key;
            final club = entry.value;
            final isMine = club.id == myClubId;
            return DataRow(
              color: isMine ? WidgetStateProperty.all(AppTheme.accent.withOpacity(0.12)) : null,
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(club.name, style: TextStyle(color: isMine ? AppTheme.accent : AppTheme.textPrimary, fontWeight: isMine ? FontWeight.bold : FontWeight.normal))),
                DataCell(Text('${club.played}')),
                DataCell(Text('${club.won}')),
                DataCell(Text('${club.drawn}')),
                DataCell(Text('${club.lost}')),
                DataCell(Text('${club.goalDifference}')),
                DataCell(Text('${club.points}', style: const TextStyle(fontWeight: FontWeight.bold))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
