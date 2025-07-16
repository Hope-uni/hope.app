import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ChildrenMapper {
  static Children childrenJsonToEntity(Map<String, dynamic> json) => Children(
        id: json["id"],
        userId: json["userId"],
        fullName: json["fullName"],
        age: json["age"],
        teaDegree:
            CatalogoObjectMapper.catalogObjectfromJson(json["teaDegree"]),
        currentPhase:
            CatalogoObjectMapper.catalogObjectfromJson(json["currentPhase"]),
        achievementCount: json["achievementCount"],
        imageUrl: json["imageUrl"],
      );
}
