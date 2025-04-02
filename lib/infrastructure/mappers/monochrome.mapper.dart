import 'package:hope_app/domain/domain.dart';

class MonochromeMapper {
  static Monochrome fromJsonMonochrome(Map<String, dynamic> json) => Monochrome(
        isMonochrome: json["isMonochrome"],
      );
}
