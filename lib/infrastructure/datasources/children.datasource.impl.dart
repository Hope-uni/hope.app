import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class ChildrenDataSourceImpl extends ChildrenDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataList<Children>> getChildrenTherapist({
    required int page,
    int? activityId,
  }) async {
    try {
      // Construir la URL dinámicamente
      String url = '/therapist/patients?page=$page&size=15';

      if (activityId != null) url += '&activityId=$activityId';

      final response = await dioServices.dio.get(url);

      final responseChildren =
          ResponseMapper.responseJsonListToEntity<Children>(
              json: response.data,
              fromJson: ChildrenMapper.childrenJsonToEntity);

      return responseChildren;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataList<Children>> getChildrenTutor(
      {required int page}) async {
    try {
      final response =
          await dioServices.dio.get('/tutor/patients?page=$page&size=15');

      final responseChildren =
          ResponseMapper.responseJsonListToEntity<Children>(
              json: response.data,
              fromJson: ChildrenMapper.childrenJsonToEntity);

      return responseChildren;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<Child>> getChild({required int idChild}) async {
    try {
      final response = await dioServices.dio.get('/patient/$idChild');

      final responseChild = ResponseMapper.responseJsonToEntity<Child>(
          json: response.data, fromJson: ChildMapper.childfromJson);

      return responseChild;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<Person>> updateChild({
    required int idChild,
    required Person child,
  }) async {
    try {
      final isLocalPath = File(child.imageUrl!).existsSync();

      final formData = FormData.fromMap({
        $userNameProfile: child.username,
        $emailProfile: child.email,
        $firstNameProfile: child.firstName,
        $secondNameProfile: child.secondName,
        $surnameProfile: child.surname,
        $secondSurnameProfile: child.secondSurname,
        $addressProfile: child.address.trim(),
        $birthdayProfile: child.birthday,
        $genderProfile: child.gender,
        if (isLocalPath)
          $imageFile: await MultipartFile.fromFile(
            child.imageUrl!,
            filename: child.imageUrl!.split('/').last,
          )
      });

      final response =
          await dioServices.dio.put('/patient/$idChild', data: formData);

      final responseChild = ResponseMapper.responseJsonToEntity<Person>(
          json: response.data, fromJson: PersonMapper.personFromJson);

      return responseChild;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<Observation>> createObservation({
    required int idChild,
    required String description,
  }) async {
    try {
      final response =
          await dioServices.dio.post('/observation/id-patient', data: {
        $patientId: idChild,
        $descriptionChild: description.trim(),
      });

      final responseObservation =
          ResponseMapper.responseJsonToEntity<Observation>(
              json: response.data,
              fromJson: ObservationMapper.observationfromJson);

      return responseObservation;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataList<Children>> getChildrenforActivity({
    required int page,
    required int idActivity,
  }) async {
    try {
      final response = await dioServices.dio
          .get('/patient/availableForActivity/$idActivity?page=$page&size=15');

      final responseChild = ResponseMapper.responseJsonListToEntity<Children>(
          json: response.data, fromJson: ChildrenMapper.childrenJsonToEntity);

      return responseChild;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<Monochrome>> updateMonochrome({
    required int idChild,
  }) async {
    try {
      final response = await dioServices.dio
          .patch('/healthRecord/change-monochrome/$idChild');

      final responseMonochrome =
          ResponseMapper.responseJsonToEntity<Monochrome>(
              json: response.data,
              fromJson: MonochromeMapper.fromJsonMonochrome);

      return responseMonochrome;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
