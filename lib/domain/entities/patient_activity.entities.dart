import 'package:hope_app/domain/domain.dart' show CurrentCompletedActivity;

class PatientActivity {
  CurrentCompletedActivity? latestCompletedActivity;
  CurrentCompletedActivity? currentActivity;

  PatientActivity({
    this.latestCompletedActivity,
    this.currentActivity,
  });
}
