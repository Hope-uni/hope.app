import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ActivitiesMapper {
  static Activities activitiesFromJson(Map<String, dynamic> json) => Activities(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        satisfactoryPoints: json["satisfactoryPoints"],
        phase: CatalogoObjectMapper.catalogObjectfromJson(json["phase"]),
        assignments: json["assignments"] == null
            ? null
            : List<int>.from(json["assignments"].map((x) => x)).toList(),
      );
}
