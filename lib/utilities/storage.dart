import 'package:chautari/utilities/constants.dart';
import 'package:get_storage/get_storage.dart';

class ChautariStorage {
  final GetStorage box = GetStorage();

  write(String key, Map<String, dynamic> json) async {
    await box.write(AppConstant.userKey, json);
  }

  remove(String key) async {
    await box.remove(key);
  }

  read(String key) {
    return box.read(key);
  }
}
