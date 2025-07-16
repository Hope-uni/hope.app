import 'package:hope_app/domain/domain.dart';

abstract class ProfilePersonDataSource {
  Future<ResponseDataObject<ProfilePerson>> updateProfileTutor(
      {required ProfilePerson profilePerson, required int idTutor});
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      {required ProfilePerson profilePerson, required int idTherapist});
}
