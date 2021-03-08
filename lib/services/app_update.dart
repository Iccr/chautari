import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateService extends GetxService {
  String version;
  String buildNumber;

  String serverVersion;
  String serverBuildNumber;

  bool forceUpdate;
  bool shouldUPdate = false;

  static const APP_STORE_URL =
      'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

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
    this.serverVersion = serverVersion;
    this.serverBuildNumber = serverBuildNumber;
    this.forceUpdate = forceUpdate;

    if (this.version != this.serverVersion) {
      this.shouldUPdate = true;
    }
  }

  update() {
    var url = GetPlatform.isAndroid
        ? AppUpdateService.PLAY_STORE_URL
        : AppUpdateService.APP_STORE_URL;

    _launchURL(url);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
