import 'package:android_intent_plus/android_intent.dart';

class HotspotHelper {
  static Future<void> openHotspotSettings() async {
    const intent = AndroidIntent(action: 'android.settings.TETHER_SETTINGS');
    await intent.launch();
  }

  static Future<void> openWifiSettings() async {
    const intent = AndroidIntent(action: 'android.settings.WIFI_SETTINGS');
    await intent.launch();
  }
}
