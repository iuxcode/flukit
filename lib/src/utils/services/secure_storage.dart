part of '../flu_utils.dart';

extension FlukitSecureStorageService on FlukitInterface {
  _FluStorageService get secureStorage => _FluStorageService();
}

// store user credentials, API tokens, secret API keys in local storage
// using flutter_secure_storage
class _FluStorageService  {
  final _secureStorage = const FlutterSecureStorage();
  
  AndroidOptions getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  /// containsKeyInSecureData method
  /// responsible for checking whether the storage contains the provided key or no
  Future<bool> containsKey(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key, aOptions: getAndroidOptions());
    return containsKey;
  }

  /// writing data into secure storage
  Future<void> write(FluSecureStorageItem item) async {
    await _secureStorage.write(key: item.key, value: item.value, aOptions: getAndroidOptions());
  }

  /// read the secured data concerning the key
  Future<String?> read(String key) async {
    var readData = await _secureStorage.read(key: key, aOptions: getAndroidOptions());
    return readData;
  }

  /// read all the secured data
  Future<List<FluSecureStorageItem>> readAll() async {
    var allData = await _secureStorage.readAll(aOptions: getAndroidOptions());
    List<FluSecureStorageItem> list = allData.entries.map((e) => FluSecureStorageItem(e.key, e.value)).toList();
    return list;
  }

  /// delete a key-value pair
  Future<void> delete(FluSecureStorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: getAndroidOptions());
  }

  /// delete all the secured data
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll(aOptions: getAndroidOptions());
  }
}

class FluSecureStorageItem {
  final String key;
  final String value;

  FluSecureStorageItem(this.key, this.value);
}
