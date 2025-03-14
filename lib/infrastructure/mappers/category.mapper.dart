import 'package:hope_app/domain/domain.dart';

class CategoryMapper {
  static Category categoryfromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );
}
