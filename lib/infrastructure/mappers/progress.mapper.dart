import 'package:hope_app/domain/domain.dart';

class ProgressMapper {
  static Progress progressfromJson(Map<String, dynamic> json) => Progress(
        generalProgress: json["generalProgress"],
        phaseProgress: json["phaseProgress"],
      );
}
