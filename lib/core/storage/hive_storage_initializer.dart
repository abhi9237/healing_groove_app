import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'storage_keys.dart';

class HiveStorageInitializer {
  HiveStorageInitializer._();

  static Future<void> init() async {
    final appDocDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocDirectory.path);
    await Hive.openBox(StorageKeys.appBox);
  }
}
