import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ChildrenRepositoryImpl extends ChildrenRepository {
  final ChildrenDataSource dataSource;

  ChildrenRepositoryImpl({ChildrenDataSource? dataSource})
      : dataSource = dataSource ?? ChildrenDataSourceImpl();

  @override
  Future<ResponseDataList<Children>> getChildrenTherapist({required int page}) {
    return dataSource.getChildrenTherapist(page: page);
  }

  @override
  Future<ResponseDataList<Children>> getChildrenTutor({required int page}) {
    return dataSource.getChildrenTutor(page: page);
  }

  @override
  Future<ResponseDataObject<Child>> getChild({required int idChild}) {
    return dataSource.getChild(idChild: idChild);
  }

  @override
  Future<ResponseDataObject<Person>> updateChild({
    required int idChild,
    required Person child,
  }) {
    return dataSource.updateChild(idChild: idChild, child: child);
  }

  @override
  Future<ResponseDataObject<Observation>> createObservation({
    required int idChild,
    required String description,
  }) {
    return dataSource.createObservation(
      idChild: idChild,
      description: description,
    );
  }
}
