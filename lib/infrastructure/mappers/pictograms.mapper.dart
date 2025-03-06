import 'package:hope_app/domain/domain.dart';

class PictogramsMapper {
  static PictogramAchievements pictogramAchievementsfromJson(
          Map<String, dynamic> json) =>
      PictogramAchievements(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        category: json["Category"] == null
            ? null
            : categoryfromJson(json["Category"]),
      );

  static Category categoryfromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );
}
