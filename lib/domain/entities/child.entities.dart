import 'package:hope_app/domain/domain.dart';

class Child extends Person {
  int id;
  int userId;
  String fullName;
  int age;
  CatalogObject teaDegree;
  CatalogObject currentPhase;
  Progress progress;
  List<Observation>? observations;
  List<PictogramAchievements>? achievements;
  PersonTutorTherapist tutor;
  PersonTutorTherapist? therapist;
  CurrentActivity? currentActivity;
  List<ActivityChild>? activities;
  List<PictogramAchievements>? pictograms;

  Child({
    required this.id,
    required this.userId,
    required this.fullName,
    required super.firstName,
    super.secondName,
    required super.surname,
    super.secondSurname,
    required super.gender,
    required this.age,
    super.image,
    required super.username,
    required super.email,
    required super.birthday,
    required super.address,
    required this.teaDegree,
    required this.currentPhase,
    required this.progress,
    this.observations,
    this.achievements,
    required this.tutor,
    this.therapist,
    this.currentActivity,
    this.activities,
    this.pictograms,
  });

  Child copyWith({
    String? firstName,
    String? secondName,
    String? surname,
    String? secondSurname,
    String? gender,
    String? image,
    String? username,
    String? email,
    String? birthday,
    String? address,
    int? id,
    int? userId,
    String? fullName,
    int? age,
    CatalogObject? teaDegree,
    CatalogObject? currentPhase,
    Progress? progress,
    PersonTutorTherapist? tutor,
    List<Observation>? observations,
    List<PictogramAchievements>? achievements,
    PersonTutorTherapist? therapist,
    CurrentActivity? currentActivity,
    List<ActivityChild>? activities,
    List<PictogramAchievements>? pictograms,
  }) =>
      Child(
        firstName: firstName ?? super.firstName,
        secondName: secondName ?? super.secondName,
        surname: surname ?? super.surname,
        secondSurname: secondSurname ?? super.secondSurname,
        gender: gender ?? super.gender,
        image: image ?? super.image,
        username: username ?? super.username,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        address: address ?? super.address,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        fullName: fullName ?? this.fullName,
        age: age ?? this.age,
        teaDegree: teaDegree ?? this.teaDegree,
        currentPhase: currentPhase ?? this.currentPhase,
        progress: progress ?? this.progress,
        tutor: tutor ?? this.tutor,
        observations: observations ?? this.observations,
        achievements: achievements ?? this.achievements,
        therapist: therapist ?? this.therapist,
        currentActivity: currentActivity ?? this.currentActivity,
        activities: activities ?? this.activities,
        pictograms: pictograms ?? this.pictograms,
      );
}

class ActivityChild {
  int id;
  CatalogObject phase;
  String name;
  String description;
  int satisfactoryPoints;

  ActivityChild({
    required this.id,
    required this.phase,
    required this.name,
    required this.description,
    required this.satisfactoryPoints,
  });
}

class CurrentActivity {
  int id;
  String name;
  int satisfactoryPoints;
  int satisfactoryAttempts;
  int progress;
  String description;
  CatalogObject phase;

  CurrentActivity({
    required this.id,
    required this.name,
    required this.satisfactoryPoints,
    required this.satisfactoryAttempts,
    required this.progress,
    required this.description,
    required this.phase,
  });
}

class Progress {
  String generalProgress;
  int phaseProgress;

  Progress({
    required this.generalProgress,
    required this.phaseProgress,
  });
}

class PersonTutorTherapist {
  int id;
  int userId;
  String? image;
  String fullName;
  String email;
  String username;
  String phoneNumber;
  String? telephone;

  PersonTutorTherapist({
    required this.id,
    required this.userId,
    this.image,
    required this.fullName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    this.telephone,
  });
}
