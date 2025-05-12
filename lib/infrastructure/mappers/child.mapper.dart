import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ChildMapper {
  static Child childfromJson(Map<String, dynamic> json) => Child(
        id: json["id"],
        userId: json["userId"],
        fullName: json["fullName"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        surname: json["surname"],
        secondSurname: json["secondSurname"],
        gender: json["gender"],
        age: json["age"],
        imageUrl: json["imageUrl"],
        username: json["username"],
        email: json["email"],
        birthday: json["birthday"],
        address: json["address"],
        teaDegree:
            CatalogoObjectMapper.catalogObjectfromJson(json["teaDegree"]),
        currentPhase:
            CatalogoObjectMapper.catalogObjectfromJson(json["currentPhase"]),
        progress: ProgressMapper.progressfromJson(json["progress"]),
        observations: json["observations"] == null
            ? null
            : List<Observation>.from(json["observations"]
                .map((x) => ObservationMapper.observationfromJson(x))),
        achievements: json["achievements"] == null
            ? null
            : List<PictogramAchievements>.from(json["achievements"]
                .map((x) => PictogramsMapper.pictogramAchievementsfromJson(x))),
        tutor: personfromJson(json["tutor"]),
        therapist: json["therapist"] == null
            ? null
            : personfromJson(json["therapist"]),
        currentActivity: json["currentActivity"] == null
            ? null
            : CurrentCompletedActivityMapper.currentCompletedActivityfromJson(
                json["currentActivity"]),
        latestCompletedActivity: json["latestCompletedActivity"] == null
            ? null
            : CurrentCompletedActivityMapper.currentCompletedActivityfromJson(
                json["latestCompletedActivity"]),
        activities: json["activities"] == null
            ? null
            : List<ActivityChild>.from(
                json["activities"].map((x) => activityfromJson(x))),
        pictograms: json["pictograms"] == null
            ? null
            : List<PictogramAchievements>.from(json["pictograms"]
                .map((x) => PictogramsMapper.pictogramAchievementsfromJson(x))),
        isMonochrome: json["isMonochrome"],
        isVerified: json["isVerified"],
      );

  static ActivityChild activityfromJson(Map<String, dynamic> json) =>
      ActivityChild(
        id: json["id"],
        phase: CatalogoObjectMapper.catalogObjectfromJson(json["phase"]),
        name: json["name"],
        description: json["description"],
        satisfactoryPoints: json["satisfactoryPoints"],
      );

  static PersonTutorTherapist personfromJson(Map<String, dynamic> json) =>
      PersonTutorTherapist(
        id: json["id"],
        userId: json["userId"],
        imageUrl: json["imageUrl"],
        fullName: json["fullName"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        telephone: json["telephone"],
      );
}
