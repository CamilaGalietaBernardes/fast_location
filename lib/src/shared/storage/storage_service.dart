import 'package:hive_flutter/hive_flutter.dart';
import 'address_history_model.dart';

class StorageService {
  static const String _historyBoxName = 'address_history';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AddressHistoryModelAdapter());
    await Hive.openBox<AddressHistoryModel>(_historyBoxName);
  }

  Box<AddressHistoryModel> get historyBox =>
      Hive.box<AddressHistoryModel>(_historyBoxName);

  Future<void> saveAddress(AddressHistoryModel address) async {
    // Evita duplicatas: remove entrada anterior com mesmo CEP
    final existing = historyBox.values
        .where((a) => a.cep == address.cep)
        .toList();
    for (final item in existing) {
      await item.delete();
    }
    await historyBox.add(address);
  }

  List<AddressHistoryModel> getHistory() {
    final items = historyBox.values.toList();
    items.sort((a, b) => b.consultedAt.compareTo(a.consultedAt));
    return items;
  }

  Future<void> clearHistory() async {
    await historyBox.clear();
  }
}
