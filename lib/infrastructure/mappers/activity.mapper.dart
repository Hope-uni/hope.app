import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ActivityMapper {
  static Map<String, dynamic> toJsonActivity(CreateActivity activity) => {
        "name": activity.name,
        "description": activity.description,
        "satisfactoryPoints": activity.satisfactoryPoints,
        "pictogramSentence":
            List<int>.from(activity.pictogramSentence.map((x) => x)),
        "phaseId": activity.phaseId,
      };

  static Activity fromJsonActivity(Map<String, dynamic> json) => Activity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        satisfactoryPoints: json["satisfactoryPoints"],
        phase: CatalogoObjectMapper.catalogObjectfromJson(json["phase"]),
        user: fromJsonUser(json["user"]),
        activitySolution: List<PictogramAchievements>.from(
            json["activitySolution"]
                .map((x) => PictogramsMapper.pictogramAchievementsfromJson(x))),
        assignments: [],
      );

  static fromJsonUser(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
      );
}
