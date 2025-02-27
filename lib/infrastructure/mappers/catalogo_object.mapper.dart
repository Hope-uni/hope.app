import 'package:hope_app/domain/domain.dart';

class CatalogoObjectMapper {
  static CatalogObject catalogObjectfromJson(Map<String, dynamic> json) =>
      CatalogObject(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
}
