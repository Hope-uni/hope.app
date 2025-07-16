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

  PictogramAchievements copyWith({
    int? id,
    String? name,
    String? imageUrl,
    Category? category,
  }) =>
      PictogramAchievements(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        category: category ?? this.category,
      );
}
