import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ProfilePersonRepositoryImpl extends ProfilePersonRepository {
  final ProfilePersonDataSource dataSource;

  ProfilePersonRepositoryImpl({ProfilePersonDataSource? dataSource})
      : dataSource = dataSource ?? ProfilePersonDataSourceImpl();

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      {required ProfilePerson profilePerson, required int idTherapist}) {
    return dataSource.updateProfileTherapist(
        profilePerson: profilePerson, idTherapist: idTherapist);
  }

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTutor(
      {required ProfilePerson profilePerson, required int idTutor}) {
    return dataSource.updateProfileTutor(
        profilePerson: profilePerson, idTutor: idTutor);
  }
}
