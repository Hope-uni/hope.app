import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ProfilePersonRepositoryImpl extends ProfilePersonRepository {
  final ProfilePersonDataSource dataSource;

  ProfilePersonRepositoryImpl({ProfilePersonDataSource? dataSource})
      : dataSource = dataSource ?? ProfilePersonDataSourceImpl();

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      ProfilePerson profilePerson) {
    return dataSource.updateProfileTherapist(profilePerson);
  }

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTutor(
      ProfilePerson profilePerson) {
    return dataSource.updateProfileTutor(profilePerson);
  }
}
