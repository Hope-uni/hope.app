import 'package:hope_app/domain/domain.dart';

abstract class ChildrenRepository {
  Future<ResponseDataList<Children>> getChildrenTherapist({required int page});
  Future<ResponseDataList<Children>> getChildrenTutor({required int page});
  Future<ResponseDataObject<Child>> getChild({required int idChild});
}
