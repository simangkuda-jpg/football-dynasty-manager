import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'club_selection_screen.dart';

class ManagerCreationScreen extends StatefulWidget {
  const ManagerCreationScreen({super.key});

  @override
  State<ManagerCreationScreen> createState() => _ManagerCreationScreenState();
}

class _ManagerCreationScreenState extends State<ManagerCreationScreen> {
  final nameController = TextEditingController();
  String selectedNationality = 'Indonesia';

  final nationalities = ['Indonesia', 'Brazil', 'Argentina', 'Portugal', 'Netherlands', 'England', 'Spain', 'Japan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manager Creation')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Manager Name', style: TextStyle(color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppTheme.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                hintText: 'Enter your name',
                hintStyle: const TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Nationality', style: TextStyle(color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: nationalities.map((n) {
                final selected = n == selectedNationality;
                return ChoiceChip(
                  label: Text(n),
                  selected: selected,
                  onSelected: (_) => setState(() => selectedNationality = n),
                  selectedColor: AppTheme.accent,
                  backgroundColor: AppTheme.surface,
                  labelStyle: TextStyle(color: selected ? Colors.black : AppTheme.textPrimary),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: nameController.text.trim().isEmpty
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ClubSelectionScreen(
                              managerName: nameController.text.trim(),
                              managerNationality: selectedNationality,
                            ),
                          ),
                        );
                      },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
