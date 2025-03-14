import 'package:hope_app/domain/domain.dart';

class PhaseMapper {
  static Phase fromJsonPhase(Map<String, dynamic> json) => Phase(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        scoreActivities: json["scoreActivities"],
      );
}
