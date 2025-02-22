import 'package:hope_app/domain/domain.dart';

abstract class ProfilePersonRepository {
  Future<ResponseDataObject<ProfilePerson>> updateProfileTutor(
      ProfilePerson profilePerson);
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      ProfilePerson profilePerson);
}
