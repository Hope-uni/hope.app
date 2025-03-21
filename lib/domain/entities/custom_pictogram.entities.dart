class CustomPictogram {
  String name;
  String imageUrl;
  int patientId;
  int? pictogramId;

  CustomPictogram({
    required this.name,
    required this.imageUrl,
    required this.patientId,
    this.pictogramId,
  });
}
