import 'package:hope_app/domain/domain.dart';

class ObservationMapper {
  static Observation observationfromJson(Map<String, dynamic> json) =>
      Observation(
        id: json["id"],
        description: json["description"],
        username: json["username"],
        createdAt: json["createdAt"],
      );
}
