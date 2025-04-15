class Categorymodel {
  final int id;
  final String name;
  final String image;
  Categorymodel({required this.id, required this.name, required this.image});
  factory Categorymodel.fromJson(Map<String, dynamic> json) {
    return Categorymodel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
