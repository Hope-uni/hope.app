import 'package:hope_app/domain/domain.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryDataSourceImpl extends CameraGalleryDataSource {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectImage() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100);

    if (photo == null) return null;

    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100);

    if (photo == null) return null;

    return photo.path;
  }
}
