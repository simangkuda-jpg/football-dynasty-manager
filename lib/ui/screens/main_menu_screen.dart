import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/career_state.dart';
import '../theme/app_theme.dart';
import 'manager_creation_screen.dart';
import 'home_dashboard_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool checkingSave = true;
  bool hasSave = false;

  @override
  void initState() {
    super.initState();
    _checkSave();
  }

  Future<void> _checkSave() async {
    final state = context.read<CareerState>();
    final loaded = await state.loadCareer();
    setState(() {
      hasSave = loaded;
      checkingSave = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sports_soccer, color: AppTheme.accent, size: 72),
                const SizedBox(height: 16),
                const Text(
                  'FOOTBALL DYNASTY',
                  style: TextStyle(color: AppTheme.textPrimary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
                const Text(
                  'MANAGER',
                  style: TextStyle(color: AppTheme.accent, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 6),
                ),
                const SizedBox(height: 48),
                if (checkingSave) const CircularProgressIndicator(color: AppTheme.accent),
                if (!checkingSave) ...[
                  if (hasSave)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const HomeDashboardScreen()),
                          );
                        },
                        child: const Text('Continue Career'),
                      ),
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textPrimary,
                        side: const BorderSide(color: AppTheme.textSecondary),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ManagerCreationScreen()),
                        );
                      },
                      child: const Text('New Career'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
