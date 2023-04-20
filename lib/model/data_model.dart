// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

class DataModel {
  String name;
  String img;
  int price;
  int stars;

  DataModel({
    required this.name,
    required this.price,
    required this.img,
    required this.stars,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json["name"],
      price: json["price"],
      img: json["img"],
      stars: json["stars"],
    );
  }
}
