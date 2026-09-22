import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/career_state.dart';
import '../../data/models/enums.dart';
import '../../data/models/tactic.dart';
import '../theme/app_theme.dart';

class TacticsScreen extends StatefulWidget {
  const TacticsScreen({super.key});

  @override
  State<TacticsScreen> createState() => _TacticsScreenState();
}

class _TacticsScreenState extends State<TacticsScreen> {
  late Tactic tactic;

  @override
  void initState() {
    super.initState();
    final state = context.read<CareerState>();
    final club = state.myClub!;
    tactic = Tactic(
      formation: club.tactic.formation,
      mentality: club.tactic.mentality,
      buildUp: club.tactic.buildUp,
      pressing: club.tactic.pressing,
      defensiveLine: club.tactic.defensiveLine,
      tempo: club.tactic.tempo,
      width: club.tactic.width,
      counterEnabled: club.tactic.counterEnabled,
      offsideTrap: club.tactic.offsideTrap,
    );
  }

  void _save() {
    final state = context.read<CareerState>();
    state.updateTactic(state.myClub!.id, tactic);
    state.saveCareer();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tactics'),
        actions: [TextButton(onPressed: _save, child: const Text('Save'))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _dropdownSection<Formation>(
            'Formation',
            Formation.values,
            tactic.formation,
            (v) => setState(() => tactic.formation = v),
            formationLabel,
          ),
          _dropdownSection<Mentality>(
            'Mentality',
            Mentality.values,
            tactic.mentality,
            (v) => setState(() => tactic.mentality = v),
            mentalityLabel,
          ),
          _dropdownSection<BuildUp>(
            'Build Up',
            BuildUp.values,
            tactic.buildUp,
            (v) => setState(() => tactic.buildUp = v),
            (v) => v.name,
          ),
          _dropdownSection<PressingLevel>(
            'Pressing',
            PressingLevel.values,
            tactic.pressing,
            (v) => setState(() => tactic.pressing = v),
            (v) => v.name,
          ),
          _dropdownSection<DefensiveLine>(
            'Defensive Line',
            DefensiveLine.values,
            tactic.defensiveLine,
            (v) => setState(() => tactic.defensiveLine = v),
            (v) => v.name,
          ),
          _dropdownSection<Tempo>(
            'Tempo',
            Tempo.values,
            tactic.tempo,
            (v) => setState(() => tactic.tempo = v),
            (v) => v.name,
          ),
          _dropdownSection<Width>(
            'Width',
            Width.values,
            tactic.width,
            (v) => setState(() => tactic.width = v),
            (v) => v.name,
          ),
          SwitchListTile(
            value: tactic.counterEnabled,
            onChanged: (v) => setState(() => tactic.counterEnabled = v),
            title: const Text('Counter Attack', style: TextStyle(color: AppTheme.textPrimary)),
            activeColor: AppTheme.accent,
          ),
          SwitchListTile(
            value: tactic.offsideTrap,
            onChanged: (v) => setState(() => tactic.offsideTrap = v),
            title: const Text('Offside Trap', style: TextStyle(color: AppTheme.textPrimary)),
            activeColor: AppTheme.accent,
          ),
        ],
      ),
    );
  }

  Widget _dropdownSection<T>(String label, List<T> options, T value, void Function(T) onChanged, String Function(T) labelOf) {
    return Card(
      color: AppTheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<T>(
            value: value,
            dropdownColor: AppTheme.surface,
            decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: AppTheme.textSecondary), border: InputBorder.none),
            style: const TextStyle(color: AppTheme.textPrimary),
            items: options.map((o) => DropdownMenuItem(value: o, child: Text(labelOf(o)))).toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ),
      ),
    );
  }
}
