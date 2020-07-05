package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.infitio.adharasocketio.AdharaSocketIoPlugin;
import xyz.luan.audioplayers.AudioplayersPlugin;
import io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin;
import pt.tribeiro.flutter_plugin_pdf_viewer.FlutterPluginPdfViewerPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import com.nover.interactivewebview.InteractiveWebviewPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.tekartik.sqflite.SqflitePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    AdharaSocketIoPlugin.registerWith(registry.registrarFor("com.infitio.adharasocketio.AdharaSocketIoPlugin"));
    AudioplayersPlugin.registerWith(registry.registrarFor("xyz.luan.audioplayers.AudioplayersPlugin"));
    FlutterAndroidLifecyclePlugin.registerWith(registry.registrarFor("io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin"));
    FlutterPluginPdfViewerPlugin.registerWith(registry.registrarFor("pt.tribeiro.flutter_plugin_pdf_viewer.FlutterPluginPdfViewerPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    InteractiveWebviewPlugin.registerWith(registry.registrarFor("com.nover.interactivewebview.InteractiveWebviewPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
