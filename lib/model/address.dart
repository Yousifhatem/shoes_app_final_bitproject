import 'package:shop_app_final/core/flutter_icons.dart';

class Address{
  String addressName;
  String street;
  String cityName;
  int zipCode;
  String id;

  Address({this.addressName, this.street, this.cityName, this.zipCode, this.id});

  toMap(){
    return {
      'addressName': addressName,
      'street': street,
      'cityName': cityName,
      'zipCode': zipCode,
    };
  }

  Address.fromMap(Map map){
    addressName = map['addressName'];
    street = map['street'];
    cityName = map['cityName'];
    zipCode = map['zipCode'];
    id = map['id'];

  }
}