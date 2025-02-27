class Children {
  int id;
  int userId;
  String fullName;
  int age;
  CatalogObject teaDegree;
  CatalogObject currentPhase;
  int achievementCount;
  //TODO: Corregir cuando el endpoint ya lo devuelva
  String? image;

  Children({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.age,
    required this.teaDegree,
    required this.currentPhase,
    required this.achievementCount,
    //TODO: Corregir cuando el endpoint ya lo devuelva
    this.image,
  });
}

class CatalogObject {
  int id;
  String name;
  String description;

  CatalogObject({
    required this.id,
    required this.name,
    required this.description,
  });
}
