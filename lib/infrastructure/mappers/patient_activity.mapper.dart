import 'package:hope_app/domain/domain.dart' show PatientActivity;
import 'package:hope_app/infrastructure/infrastructure.dart'
    show CurrentCompletedActivityMapper;

class PatientActivityMapper {
  static PatientActivity patientActivityfromJson(Map<String, dynamic> json) =>
      PatientActivity(
        latestCompletedActivity: json["latestCompletedActivity"] == null
            ? null
            : CurrentCompletedActivityMapper.currentCompletedActivityfromJson(
                json["latestCompletedActivity"]),
        currentActivity: json["currentActivity"] == null
            ? null
            : CurrentCompletedActivityMapper.currentCompletedActivityfromJson(
                json["currentActivity"]),
      );
}
