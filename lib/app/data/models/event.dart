class Event {
  String id;
  String name;
  String imageUrl;
  bool isFavorite;

  Event({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
