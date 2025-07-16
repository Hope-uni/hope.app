import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryDataSourceImpl extends CameraGalleryDataSource {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectImage() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (photo == null) return null;

    final imagePath = await _cropToSquare(imagePath: photo.path);
    return imagePath;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100,
    );

    if (photo == null) return null;

    final imagePath = await _cropToSquare(imagePath: photo.path);
    return imagePath;
  }

  Future<String?> _cropToSquare({required String imagePath}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      compressFormat: ImageCompressFormat.png,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: S.current.Recortar_imagen,
          lockAspectRatio: true,
          toolbarColor: $colorTextWhite,
          toolbarWidgetColor: $colorTextBlack,
          statusBarColor: $colorTextWhite,
          initAspectRatio: CropAspectRatioPreset.square,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: S.current.Recortar_imagen,
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    return croppedFile?.path;
  }
}
