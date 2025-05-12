import 'package:hope_app/domain/domain.dart' show CurrentCompletedActivity;
import 'package:hope_app/infrastructure/infrastructure.dart'
    show CatalogoObjectMapper;

class CurrentCompletedActivityMapper {
  static CurrentCompletedActivity currentCompletedActivityfromJson(
          Map<String, dynamic> json) =>
      CurrentCompletedActivity(
        id: json["id"],
        name: json["name"],
        satisfactoryPoints: json["satisfactoryPoints"],
        satisfactoryAttempts: json["satisfactoryAttempts"],
        progress: json["progress"],
        description: json["description"],
        phase: CatalogoObjectMapper.catalogObjectfromJson(json["phase"]),
      );
}
