import 'dart:io';

class Category{
  String id;
  String name;
  String brand;
  String description;
  String imageUrl;
  File imageToBeUpload;
  int color;

  Category({this.id, this.name, this.imageUrl, this.imageToBeUpload, this.color,this.brand, this.description,});

  Category.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    imageUrl = map['imageUrl'];
    color = map['color'];
    brand = map['brand'];
    description = map['description'];
  }

  toMap(){
    return{
      'name': name,
      'imageUrl':  imageUrl,
      'color': color,
      'brand': brand,
      'description': description,
    };
  }


}