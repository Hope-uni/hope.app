import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';

class ProfilePersonDataSourceImpl extends ProfilePersonDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      {required ProfilePerson profilePerson, required int idTherapist}) async {
    try {
      final data = ProfilePersonMapper.toJson(profilePerson);
      data.removeWhere((key, value) => value == null);

      final response =
          await dioServices.dio.put('/therapist/$idTherapist', data: data);

      final responseMapper = ResponseMapper.responseJsonToEntity<ProfilePerson>(
        json: response.data,
        fromJson: ProfilePersonMapper.profilePersonJsonToEntity,
      );

      return responseMapper;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTutor(
      {required ProfilePerson profilePerson, required int idTutor}) async {
    try {
      final data = ProfilePersonMapper.toJson(profilePerson);
      data.removeWhere((key, value) => value == null);

      final response = await dioServices.dio.put('/tutor/$idTutor', data: data);

      final responseMapper = ResponseMapper.responseJsonToEntity<ProfilePerson>(
        json: response.data,
        fromJson: ProfilePersonMapper.profilePersonJsonToEntity,
      );

      return responseMapper;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
