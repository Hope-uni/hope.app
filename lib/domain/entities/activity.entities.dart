import 'package:hope_app/domain/domain.dart';

class Activity {
  int id;
  String name;
  String description;
  int satisfactoryPoints;
  CatalogObject phase;
  List<int> assignments;
  List<PictogramAchievements> activitySolution;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.satisfactoryPoints,
    required this.phase,
    required this.assignments,
    required this.activitySolution,
  });
}

class CreateActivity {
  String name;
  String description;
  int satisfactoryPoints;
  List<int> pictogramSentence;
  int phaseId;

  CreateActivity({
    required this.name,
    required this.description,
    required this.satisfactoryPoints,
    required this.pictogramSentence,
    required this.phaseId,
  });

  CreateActivity copyWith({
    String? name,
    String? description,
    int? satisfactoryPoints,
    List<int>? pictogramSentence,
    int? phaseId,
  }) =>
      CreateActivity(
        name: name ?? this.name,
        description: description ?? this.description,
        satisfactoryPoints: satisfactoryPoints ?? this.satisfactoryPoints,
        pictogramSentence: pictogramSentence ?? this.pictogramSentence,
        phaseId: phaseId ?? this.phaseId,
      );
}
