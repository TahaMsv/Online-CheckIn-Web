class Extra {
  Extra({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.image,
  });

  int id;
  String title;
  String description;
  String imageUrl;
  double price;
  String image;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    id: json["Id"],
    title: json["Title"],
    description: json["Description"],
    imageUrl: json["ImageUrl"],
    price: json["Price"].toDouble(),
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "Description": description,
    "ImageUrl": imageUrl,
    "Price": price,
    "Image": image,
  };
}
