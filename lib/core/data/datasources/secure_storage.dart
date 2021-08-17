import 'package:hive/hive.dart';

abstract class SecureStorage {
  Future<void> saveToken(String token);

  Future<void> deleteToken(String key);

  Future<bool> getToken(String key);
}

class SecureStorageImplementation implements SecureStorage {
  @override
  Future<void> deleteToken(String key) async {
    Box<String> box = await Hive.openBox<String>('keyStorage');
    box.clear();
  }

  @override
  Future<bool> getToken(String key) async {
    Box<String> box = await Hive.openBox<String>('keyStorage');
    if (box.get('key')!.isNotEmpty) {
      box.close();
      return true;
    } else {
      box.close();
      return false;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    Box<String> box = await Hive.openBox<String>('keyStorage');
    box.put('key', token);
    print(box.get('key'));
    box.close();
  }
}
