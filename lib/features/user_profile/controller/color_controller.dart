// Your ColorNotifier class
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/theme.dart';

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier() : super(Pallete.rhinoDark800); // Initial color

  void changeColor(Color color) {
    state = color;
  }
}
