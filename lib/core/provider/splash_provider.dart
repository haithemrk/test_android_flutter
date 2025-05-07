import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  bool _showSecond = false;
  bool _scale = false;
  bool _opacity = false;

  bool get showSecond => _showSecond;
  bool get scale => _scale;
  bool get opacity => _opacity;

  Timer? _timer;

  void startAnimationSequence() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final elapsed = timer.tick * 100;

      if (elapsed >= 3000 && !_showSecond) {
        _showSecond = true;
        notifyListeners();
      }

      if (elapsed >= 3300 && !_scale) {
        _scale = true;
        notifyListeners();
      }

      if (elapsed >= 3800 && !_opacity) {
        _opacity = true;
        notifyListeners();
      }

      if (elapsed > 4000) {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
