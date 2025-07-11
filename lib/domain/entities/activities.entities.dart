import 'package:hope_app/domain/domain.dart';

class Activities {
  int id;
  String name;
  String description;
  int satisfactoryPoints;
  CatalogObject phase;
  List<int>? assignments;
  User user;

  Activities({
    required this.id,
    required this.name,
    required this.description,
    required this.satisfactoryPoints,
    required this.phase,
    required this.user,
    this.assignments,
  });
}
