import 'package:hope_app/domain/domain.dart';

class PictogramAchievements {
  int id;
  String name;
  String imageUrl;
  Category? category;

  PictogramAchievements({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.category,
  });
}
