import 'package:hope_app/domain/domain.dart' show CatalogObject;

class CurrentCompletedActivity {
  int id;
  String name;
  int satisfactoryPoints;
  int satisfactoryAttempts;
  String progress;
  String description;
  CatalogObject phase;

  CurrentCompletedActivity({
    required this.id,
    required this.name,
    required this.satisfactoryPoints,
    required this.satisfactoryAttempts,
    required this.progress,
    required this.description,
    required this.phase,
  });
}
