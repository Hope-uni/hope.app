class PictogramAchievements {
  int id;
  String name;
  String imageUrl;
  Category? category;

  PictogramAchievements({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.category,
  });
}

class Category {
  int id;
  String name;
  String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}
