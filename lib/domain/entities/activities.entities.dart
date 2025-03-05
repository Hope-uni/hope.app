import 'package:hope_app/domain/domain.dart';

class Activities {
  int id;
  String name;
  String description;
  int satisfactoryPoints;
  CatalogObject phase;
  List<Assignment>? assignments;

  Activities({
    required this.id,
    required this.name,
    required this.description,
    required this.satisfactoryPoints,
    required this.phase,
    this.assignments,
  });
}

class Assignment {
  int id;

  Assignment({
    required this.id,
  });
}
