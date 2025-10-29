//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import audioplayers_darwin
import geolocator_apple
import just_audio
import location
import package_info_plus
import path_provider_foundation
import sqlite3_flutter_libs

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  AudioplayersDarwinPlugin.register(with: registry.registrar(forPlugin: "AudioplayersDarwinPlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  LocationPlugin.register(with: registry.registrar(forPlugin: "LocationPlugin"))
  FPPPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  Sqlite3FlutterLibsPlugin.register(with: registry.registrar(forPlugin: "Sqlite3FlutterLibsPlugin"))
}
