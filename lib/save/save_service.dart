import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../data/models/manager.dart';
import '../data/models/club.dart';
import '../data/models/player.dart';
import '../data/models/match_models.dart';

class SaveService {
  static const slotFileName = 'save_slot_1.json';

  static Future<File> _saveFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$slotFileName');
  }

  static Future<bool> hasSave() async {
    final file = await _saveFile();
    return file.exists();
  }

  static Future<void> save({
    required Manager manager,
    required List<Club> clubs,
    required List<Player> players,
    required List<Fixture> fixtures,
    required int currentMatchday,
  }) async {
    final file = await _saveFile();
    final data = {
      'manager': manager.toJson(),
      'clubs': clubs.map((c) => c.toJson()).toList(),
      'players': players.map((p) => p.toJson()).toList(),
      'fixtures': fixtures.map((f) => f.toJson()).toList(),
      'currentMatchday': currentMatchday,
    };
    await file.writeAsString(jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> load() async {
    final file = await _saveFile();
    if (!await file.exists()) return null;
    final content = await file.readAsString();
    return jsonDecode(content) as Map<String, dynamic>;
  }

  static Future<void> deleteSave() async {
    final file = await _saveFile();
    if (await file.exists()) {
      await file.delete();
    }
  }
}
