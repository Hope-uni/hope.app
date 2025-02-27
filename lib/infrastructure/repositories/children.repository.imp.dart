import 'package:hope_app/domain/datasources/children.datasource.dart';
import 'package:hope_app/domain/entities/child.entities.dart';
import 'package:hope_app/domain/entities/children.entities.dart';
import 'package:hope_app/domain/entities/response_data.entities.dart';
import 'package:hope_app/domain/repositories/children.repository.dart';
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
}
