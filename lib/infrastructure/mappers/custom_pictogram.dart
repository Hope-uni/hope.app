import 'package:hope_app/domain/domain.dart';

class CustomPictogramMapper {
  static Map<String, dynamic> toJson(CustomPictogram custoPictogram) => {
        "name": custoPictogram.name,
        "imageUrl": custoPictogram.imageUrl,
        "patientId": custoPictogram.patientId,
        "pictogramId": custoPictogram.pictogramId,
      };
}
