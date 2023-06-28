enum Sounds { meditationEndDefault }

extension SoundsExtension on Sounds {
  String get name {
    switch (this) {
      case Sounds.meditationEndDefault:
        return 'sounds/meditation_end_default.mp3';
    }
  }
}
