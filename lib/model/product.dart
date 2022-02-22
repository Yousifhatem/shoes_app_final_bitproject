import 'dart:io';

class Product{
  String id;
  String categoryId;
  String name;
  String description;
  num price;
  String brand;
  String imageUrl;
  File imageToBeUpload;
  int color;
  bool isFavorite;
  double rating;
  bool isPopular;
  int numOfCount ;


  Product({this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.imageToBeUpload,
    this.color,
    this.brand,
    this.isFavorite = false,
    this.rating,
    this.isPopular = false,
    this.categoryId,
    this.numOfCount=1,
  });

  Product.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    description = map['description'];
    price = map['price'];
    imageUrl = map['imageUrl'];
    color = map['color'];
    brand = map['brand'];
    isFavorite = map['isFavorite'];
    rating = map['rating'];
    isPopular = map['isPopular'];
    categoryId = map['categoryId'];
    // numOfCount = map['numOfCount'];
  }

  toMap(){
    return{
      'id':id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl':  imageUrl,
      'color': color,
      'brand': brand,
      'isFavorite': isFavorite,
      'rating': rating,
      'isPopular': isPopular,
      'categoryId': categoryId,
      // 'numOfCount': numOfCount,

    };
  }


}