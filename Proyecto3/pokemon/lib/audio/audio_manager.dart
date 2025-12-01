// lib/audio/audio_manager.dart

import 'dart:math';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  final ja.AudioPlayer _music = ja.AudioPlayer();      // Música (uso principal)
  final ap.AudioPlayer fx = ap.AudioPlayer();          // Efectos
  final _rng = Random();

  // ============================================================
  //                    VOLUMEN GENERAL
  // ============================================================
  double _musicVolume = 1.0;
  double get musicVolume => _musicVolume;

  Future<void> setVolume(double v) async {
    _musicVolume = v.clamp(0.0, 1.0);
    await _music.setVolume(_musicVolume);

    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("volumen_musica", _musicVolume);
  }

  Future<void> cargarVolumen() async {
    final prefs = await SharedPreferences.getInstance();
    _musicVolume = prefs.getDouble("volumen_musica") ?? 1.0;
    await _music.setVolume(_musicVolume);
  }

  // ============================================================
  //                   MÚSICA NORMAL (loop opcional)
  // ============================================================
  Future<void> playMusic(String asset, {bool loop = true}) async {
    await _music.setAsset("assets/audio/$asset");
    await _music.setVolume(_musicVolume);
    _music.setLoopMode(loop ? ja.LoopMode.one : ja.LoopMode.off);
    _music.play();
  }

  // ============================================================
  //                      MÚSICA RANDOM
  // ============================================================
  Future<void> playRandomMusic(List<String> lista) async {
    if (lista.isEmpty) return;

    final track = lista[_rng.nextInt(lista.length)];

    await _music.setAsset("assets/audio/$track");
    await _music.setVolume(_musicVolume);
    _music.setLoopMode(ja.LoopMode.one);
    _music.play();
  }

  // ============================================================
  //                       EFECTOS
  // ============================================================
  Future<void> playFX(String file) async {
    fx.setReleaseMode(ap.ReleaseMode.stop);
    fx.play(ap.AssetSource("assets/audio/fx/$file"));
  }

  // ============================================================
  //                       CONTROL
  // ============================================================
  Future<void> stopMusic() async => _music.stop();

  Future<void> fadeOut() async {
    double v = _musicVolume;
    while (v > 0) {
      v -= 0.1;
      _music.setVolume(v.clamp(0.0, 1.0));
      await Future.delayed(const Duration(milliseconds: 70));
    }
  }
}

