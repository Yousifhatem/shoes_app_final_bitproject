class FireUser{
  String name;
  String address;
  String email;
  String phone;
  String password;
  String id;
  bool isAdmin;
  String imageUser;


  FireUser(
      {this.name,
      this.address,
      this.email,
      this.phone,
      this.password,
      this.id,
      this.isAdmin,
      this.imageUser,
      });

  FireUser.fromMap(Map map){
      id = map['id'];
      name = map['name'];
      address = map['address'];
      email = map['email'];
      phone = map['phone'];
      password = map['password'];
      isAdmin = map['isAdmin'] ?? false;
      imageUser = map['imageUser'];

  }

  toMap(){
    return {
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'imageUser': imageUser,
    };

  }
}

