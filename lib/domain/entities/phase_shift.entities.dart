import 'package:hope_app/domain/domain.dart';

class PhaseShift {
  CatalogObject currentPhase;
  Progress progress;
  PictogramAchievements achievement;

  PhaseShift({
    required this.currentPhase,
    required this.progress,
    required this.achievement,
  });
}
