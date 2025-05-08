import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class ProfilePersonDataSourceImpl extends ProfilePersonDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      {required ProfilePerson profilePerson, required int idTherapist}) async {
    try {
      final formData =
          await _converFormData(profilePerson: profilePerson, isTutor: false);

      final response =
          await dioServices.dio.put('/therapist/$idTherapist', data: formData);

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
      final formData =
          await _converFormData(profilePerson: profilePerson, isTutor: true);

      final response =
          await dioServices.dio.put('/tutor/$idTutor', data: formData);

      final responseMapper = ResponseMapper.responseJsonToEntity<ProfilePerson>(
        json: response.data,
        fromJson: ProfilePersonMapper.profilePersonJsonToEntity,
      );

      return responseMapper;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  Future<FormData> _converFormData({
    required ProfilePerson profilePerson,
    required bool isTutor,
  }) async {
    final isLocalPath = File(profilePerson.imageUrl!).existsSync();

    return FormData.fromMap({
      $userNameProfile: profilePerson.username,
      $emailProfile: profilePerson.email,
      $firstNameProfile: profilePerson.firstName,
      $secondNameProfile: profilePerson.secondName,
      $surnameProfile: profilePerson.surname,
      $secondSurnameProfile: profilePerson.secondSurname,
      $addressProfile: profilePerson.address,
      $identificationNumbereProfile: profilePerson.identificationNumber,
      $phoneNumberProfile: profilePerson.phoneNumber,
      $birthdayProfile: profilePerson.birthday,
      $genderProfile: profilePerson.gender,
      if (isTutor == true) $telephoneProfile: profilePerson.telephone,
      if (isLocalPath)
        $imageFile: await MultipartFile.fromFile(
          profilePerson.imageUrl!,
          filename: profilePerson.imageUrl!.split('/').last,
        )
    });
  }
}
