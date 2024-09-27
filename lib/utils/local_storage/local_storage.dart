import 'package:get_storage/get_storage.dart';

class DisLocalStorage {
  static final DisLocalStorage _instance = DisLocalStorage._internal();
  final GetStorage _storage = GetStorage();

  factory DisLocalStorage() {
    return _instance;
  }

  DisLocalStorage._internal();

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }
  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }
  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}