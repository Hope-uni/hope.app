import 'package:hope_app/domain/domain.dart';

abstract class ChildrenRepository {
  Future<ResponseDataList<Children>> getChildrenTherapist({
    required int page,
    int? activityId,
  });
  Future<ResponseDataList<Children>> getChildrenTutor({required int page});
  Future<ResponseDataObject<Child>> getChild({required int idChild});
  Future<ResponseDataObject<Person>> updateChild({
    required int idChild,
    required Person child,
  });
  Future<ResponseDataObject<Observation>> createObservation({
    required int idChild,
    required String description,
  });
}
