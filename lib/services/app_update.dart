import 'package:get/get.dart';

class AppUpdateService extends GetxService {
  String version;
  String buildNumber;

  String serverVersion;
  String serverBuildNumber;

  bool forceUpdate;

  var shouldUPdate = false;

  Future<AppUpdateService> init() async {
    return this;
  }

  setInfo(
      {String version,
      String buildNumber,
      String serverVersion,
      String serverBuildNumber,
      bool forceUPdate}) {
    this.version = version;
    this.buildNumber = buildNumber;
    this.serverBuildNumber = serverBuildNumber;
    this.forceUpdate = forceUpdate;

    if (this.version != this.serverVersion) {
      this.shouldUPdate = true;
    }
  }
}
