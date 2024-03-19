import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class CameraGalleryRepositoryImpl extends CameraGalleryRepository {
  final CameraGalleryDataSource dataSource;

  CameraGalleryRepositoryImpl({CameraGalleryDataSource? dataSource})
      : dataSource = dataSource ?? CameraGalleryDataSourceImpl();

  @override
  Future<String?> selectImage() {
    return dataSource.selectImage();
  }

  @override
  Future<String?> takePhoto() {
    return dataSource.takePhoto();
  }
}
