import 'package:hope_app/domain/domain.dart';

class Children {
  int id;
  int userId;
  String fullName;
  int age;
  CatalogObject teaDegree;
  CatalogObject currentPhase;
  int? achievementCount;
  String? imageUrl;

  Children({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.age,
    required this.teaDegree,
    required this.currentPhase,
    required this.achievementCount,
    this.imageUrl,
  });
}
