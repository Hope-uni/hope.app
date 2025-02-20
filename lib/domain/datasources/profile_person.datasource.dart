import 'package:hope_app/domain/domain.dart';

abstract class ProfilePersonDataSource {
  Future<ResponseDataObject<ProfilePerson>> updateProfileTutor(
      ProfilePerson profilePerson);
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      ProfilePerson profilePerson);
}
