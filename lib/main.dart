import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/career_state.dart';
import 'ui/theme/app_theme.dart';
import 'ui/screens/main_menu_screen.dart';

void main() {
  runApp(const FootballDynastyApp());
}

class FootballDynastyApp extends StatelessWidget {
  const FootballDynastyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CareerState(),
      child: MaterialApp(
        title: 'Football Dynasty: Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const MainMenuScreen(),
      ),
    );
  }
}
