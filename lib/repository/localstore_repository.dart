import 'package:shared_preferences/shared_preferences.dart';

class LocalstoreRepository {
  final SharedPreferences _prefs;

  LocalstoreRepository(this._prefs);

  Future<void> storeSelectedKind(String kind) async {
    await _prefs.setString('selected_kind', kind);
  }

  Future<String?> getSelectedKind() async {
    return _prefs.getString('selected_kind');
  }
}
