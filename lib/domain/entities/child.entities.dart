import 'package:hope_app/domain/domain.dart';

class Child {
  int id;
  int userId;
  String fullName;
  String firstName;
  String? secondName;
  String surname;
  String? secondSurname;
  String gender;
  int age;
  String? image;
  String username;
  String email;
  String birthday;
  String address;
  CatalogObject teaDegree;
  CatalogObject currentPhase;
  Progress progress;
  List<Observation>? observations;
  List<CatalogObjectCategory>? achievements;
  Person tutor;
  Person? therapist;
  CurrentActivity? currentActivity;
  List<Activity>? activities;
  List<CatalogObjectCategory>? pictograms;

  Child({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.firstName,
    this.secondName,
    required this.surname,
    this.secondSurname,
    required this.gender,
    required this.age,
    this.image,
    required this.username,
    required this.email,
    required this.birthday,
    required this.address,
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
}

class Activity {
  int id;
  CatalogObject phase;
  String name;
  String description;
  int satisfactoryPoints;

  Activity({
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

class Observation {
  int id;
  String description;
  String username;
  String createdAt;

  Observation({
    required this.id,
    required this.description,
    required this.username,
    required this.createdAt,
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

class Person {
  int id;
  int userId;
  String? image;
  String fullName;
  String email;
  String username;
  String phoneNumber;
  String? telephone;

  Person({
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
