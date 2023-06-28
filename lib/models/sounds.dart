enum Sounds { meditationEnd }

extension SoundsExtension on Sounds {
  String get name {
    switch (this) {
      case Sounds.meditationEnd:
        return 'sounds/meditation_end_default.mp3';
    }
  }
}
