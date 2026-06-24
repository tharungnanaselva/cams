import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _box = GetStorage();

  static const String tokenKey = 'api_token';

  static void saveToken(String token) {
    _box.write(tokenKey, token);
  }

  static String? getToken() {
    return _box.read(tokenKey);
  }

  static void removeToken() {
    _box.remove(tokenKey);
  }

  static bool isLoggedIn() {
    return getToken() != null;
  }

  static void clear() {
    _box.erase();
  }
}
