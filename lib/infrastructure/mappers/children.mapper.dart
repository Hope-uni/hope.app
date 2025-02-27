import 'package:hope_app/domain/domain.dart';

class ChildrenMapper {
  static Children childrenJsonToEntity(Map<String, dynamic> json) => Children(
        id: json["id"],
        userId: json["userId"],
        fullName: json["fullName"],
        age: json["age"],
        teaDegree: catalogObjectfromJson(json["teaDegree"]),
        currentPhase: catalogObjectfromJson(json["currentPhase"]),
        achievementCount: json["achievementCount"],
        //TODO: Corregir cuando el endpoint ya lo devuelva
        image: json["image"],
      );

  static CatalogObject catalogObjectfromJson(Map<String, dynamic> json) =>
      CatalogObject(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
}
