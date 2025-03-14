import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class PictogramsMapper {
  static PictogramAchievements pictogramAchievementsfromJson(
          Map<String, dynamic> json) =>
      PictogramAchievements(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        category: json["Category"] == null
            ? null
            : CategoryMapper.categoryfromJson(json["Category"]),
      );
}
