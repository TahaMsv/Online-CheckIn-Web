import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/extra.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('Extra', () {
    test('Test fromJson() method', () {
      // Arrange
      var json = MyJson.selectSeatExtrasResJson["Body"]["Extras"][0];
      final extra = Extra.fromJson(json);

      // Assert
      expect(extra.id, json["Id"]);
      expect(extra.title, json["Title"]);
      expect(extra.description, json["Description"]);
      expect(extra.imageUrl, json["ImageUrl"]);
      expect(extra.price, json["Price"]);
      expect(extra.image, json["Image"]);
    });

    test('Test toJson() method', () {
      // Arrange
      final extra = Extra(
        id: 1,
        title: "Example Extra",
        description: "This is an example extra",
        imageUrl: "https://example.com/image.jpg",
        price: 9.99,
        image: "example_image.jpg",
      );

      // Act
      final json = extra.toJson();

      // Assert
      expect(json["Id"], 1);
      expect(json["Title"], "Example Extra");
      expect(json["Description"], "This is an example extra");
      expect(json["ImageUrl"], "https://example.com/image.jpg");
      expect(json["Price"], 9.99);
      expect(json["Image"], "example_image.jpg");
    });
  });
}
