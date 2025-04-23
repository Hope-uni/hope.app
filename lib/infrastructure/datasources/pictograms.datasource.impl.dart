import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';

class PictogramsDataSourceImpl extends PictogramsDataSource {
  final dioServices = DioService();
  @override
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
    required int? idCategory,
    required String? namePictogram,
  }) async {
    try {
      // Construir la URL dinámicamente
      String url = '/pictogram/?page=$indexPage&size=15';

      if (idCategory != null) url += '&categoryId=$idCategory';
      if (namePictogram != null) url += '&pictogramName=$namePictogram';

      final response = await dioServices.dio.get(url);

      final responsePictograms =
          ResponseMapper.responseJsonListToEntity<PictogramAchievements>(
              json: response.data,
              fromJson: PictogramsMapper.pictogramAchievementsfromJson);

      return responsePictograms;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataList<Category>> getCategoryPictograms() async {
    try {
      final response = await dioServices.dio.get('/category');

      final responseCategoryPictograms =
          ResponseMapper.responseJsonListToEntity<Category>(
              json: response.data, fromJson: CategoryMapper.categoryfromJson);

      return responseCategoryPictograms;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<PictogramAchievements>> createCustomPictogram(
      {required CustomPictogram customPictogram}) async {
    try {
      final data = CustomPictogramMapper.toJson(customPictogram);

      final response =
          await dioServices.dio.post('/patientPictogram', data: data);

      final responseCustomPictograms =
          ResponseMapper.responseJsonToEntity<PictogramAchievements>(
        json: response.data,
        fromJson: PictogramsMapper.pictogramAchievementsfromJson,
      );

      return responseCustomPictograms;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataList<PictogramAchievements>> getCustomPictograms({
    required int indexPage,
    required int idChild,
    required int? idCategory,
    required String? namePictogram,
  }) async {
    try {
      // Construir la URL dinámicamente
      String url =
          '/patientPictogram/patient-pictograms/$idChild?page=$indexPage&size=15';

      if (idCategory != null) url += '&categoryId=$idCategory';
      if (namePictogram != null) url += '&pictogramName=$namePictogram';

      final response = await dioServices.dio.get(url);

      final responseCustomPictograms =
          ResponseMapper.responseJsonListToEntity<PictogramAchievements>(
        json: response.data,
        fromJson: PictogramsMapper.pictogramAchievementsfromJson,
      );

      return responseCustomPictograms;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<ResponseData>> deleteCustomPictograms({
    required int idPictogram,
    required int idChild,
  }) async {
    try {
      final response = await dioServices.dio.delete(
        '/patientPictogram/$idPictogram',
        data: {"patientId": idChild},
      );

      final responseCustomPictogram =
          ResponseMapper.responseJsonToEntity<ResponseData>(
              json: response.data);

      return responseCustomPictogram;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<PictogramAchievements>> updateCustomPictograms({
    required CustomPictogram pictogram,
    required int idPictogram,
  }) async {
    try {
      final data = CustomPictogramMapper.toJson(pictogram);
      data.removeWhere((key, value) => value == null);

      final response = await dioServices.dio.put(
        '/patientPictogram/$idPictogram',
        data: data,
      );

      final responseCustomPictograms =
          ResponseMapper.responseJsonToEntity<PictogramAchievements>(
        json: response.data,
        fromJson: PictogramsMapper.pictogramAchievementsfromJson,
      );

      return responseCustomPictograms;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataList<PictogramAchievements>> getPictogramsPatient({
    required int indexPage,
    required int? idCategory,
  }) async {
    try {
      // Construir la URL dinámicamente
      String url = '/patientPictogram?page=$indexPage&size=15';

      if (idCategory != null) url += '&categoryId=$idCategory';

      final response = await dioServices.dio.get(url);

      final responsePictogramsPatient =
          ResponseMapper.responseJsonListToEntity<PictogramAchievements>(
        json: response.data,
        fromJson: PictogramsMapper.pictogramAchievementsfromJson,
      );

      return responsePictogramsPatient;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
