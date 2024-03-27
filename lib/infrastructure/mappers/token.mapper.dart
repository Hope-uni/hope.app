import 'package:hope_app/domain/domain.dart';

class TokenMapper {
  static Token tokenJsonToEntity(
    Map<String, dynamic> json,
  ) =>
      Token(
        accessToken: json["accessToken"] ?? '',
        refreshToken: json["refreshToken"] ?? '',
      );
}
