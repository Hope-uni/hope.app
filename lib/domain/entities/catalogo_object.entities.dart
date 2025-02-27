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

class CatalogObjectCategory {
  int id;
  String name;
  String imageUrl;
  Category? category;

  CatalogObjectCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.category,
  });
}

class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });
}
