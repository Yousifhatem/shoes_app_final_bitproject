
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app_final/model/address.dart';
import 'package:shop_app_final/model/category.dart';
import 'package:shop_app_final/model/fir_user.dart';
import 'package:shop_app_final/model/product.dart';


class FireStoreHelper{
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper =  FireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  createUserInFs(FireUser user) async{
     await firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
  }

  editUser(FireUser user) async{
    await firebaseFirestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<FireUser> getUserFromFirebase(String id) async{
    DocumentSnapshot<Map<String, dynamic>> document = await firebaseFirestore.collection('users').doc(id).get();
    Map<String, dynamic> userData = document.data();
    userData['id'] = document.id;
    FireUser fireUser = FireUser.fromMap(userData);
    return fireUser;
  }





// for category
  addNewCategory(Category category) async{
    await firebaseFirestore.collection('brands').add(category.toMap());
    getAllCategory();
  }

  // updateCategory(Category category) async{
  //   await firebaseFirestore.collection('brands').doc(category.id).update(category.toMap());
  // }



  editCategory(Category category) async{
    await firebaseFirestore.collection('brands').doc(category.id).update(category.toMap());
  }

  deleteCategory(String categoryId) async{
    await firebaseFirestore.collection('brands').doc(categoryId).delete();
  }

  Future<List<Category>> getAllCategory() async{
    QuerySnapshot<Map<String, dynamic>> allProductsSnapshot = await firebaseFirestore.collection('brands').get();

    List<Category> allCategories = allProductsSnapshot.docs.map((e){
      Map<String, dynamic> documentMap = e.data();
      documentMap['id'] = e.id;
      Category category = Category.fromMap(documentMap);
      return category;
    }).toList();
    return allCategories;
  }


  // for product

  addNewProduct(Product product) async{
    await firebaseFirestore.collection('products').add(product.toMap());
    getAllProducts();
  }

  editProduct(Product newProduct) async{
    await firebaseFirestore.collection('products').doc(newProduct.id).update(newProduct.toMap());
  }

  deleteProduct(String productId) async{
    await firebaseFirestore.collection('products').doc(productId).delete();
  }

  Future<Product> getOneProduct(String productId) async{
    DocumentSnapshot<Map<String, dynamic>> productSnapshot = await firebaseFirestore.collection('products').doc(productId).get();
    Map<String, dynamic> productMap = productSnapshot.data();
    productMap['id'] = productSnapshot.id;
    Product product = Product.fromMap(productMap);
    return product;
  }

  Future<List<Product>> getAllProducts() async{
    QuerySnapshot<Map<String, dynamic>> allProductsSnapshot = await firebaseFirestore.collection('products').get();

    List<Product> allProducts = allProductsSnapshot.docs.map((e){
      Map<String, dynamic> documentMap = e.data();
      documentMap['id'] = e.id;
      Product product = Product.fromMap(documentMap);
      return product;
    }).toList();
    return allProducts;
  }

  Future<String> uploadImage(File file) async{
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    Reference reference = firebaseStorage.ref('products/$fileName');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  addProductToCart(Product product) async {
    String myid = FirebaseAuth.instance.currentUser.uid;
    firebaseFirestore.collection('users').doc(myid).collection('cart').add(product.toMap());
  }

  addProductToFavorite(Product product) async {
    String myid = FirebaseAuth.instance.currentUser.uid;
    await firebaseFirestore.collection('users').doc(myid).collection('favorite').doc(product.id).set(product.toMap());
  }
  // editfavProduct(Product product) async{
  //   String myid = FirebaseAuth.instance.currentUser.uid;
  //   await firebaseFirestore.collection('users').doc(myid).collection('favorite').doc(product.id).update(product.toMap());
  // }
  deleteProductToFavorite(String productId) async {
    String myid = FirebaseAuth.instance.currentUser.uid;
    //log('$productId');
    await firebaseFirestore.collection('users').doc(myid).collection('favorite').doc(productId).delete();
  }

  Future<List<Product>> getAllFavoriteProducts() async{
    String myid = FirebaseAuth.instance.currentUser.uid;
    QuerySnapshot<Map<String, dynamic>> allFavoriteProductsSnapshot =
    await firebaseFirestore.collection('users').doc(myid).collection('favorite').get();
    List<Product> allFavoriteProducts = allFavoriteProductsSnapshot.docs.map((e){
      Map<String, dynamic> documentMap = e.data();
      documentMap['id'] = e.id;
      Product product = Product.fromMap(documentMap);
      return product;
    }).toList();
    return allFavoriteProducts;
  }


  Future<List<Product>> getAllCartProducts() async{
    String myid = FirebaseAuth.instance.currentUser.uid;
    QuerySnapshot<Map<String, dynamic>> allCartProductsSnapshot =
    await firebaseFirestore.collection('users').doc(myid).collection('cart').get();
    List<Product> allCartProducts = allCartProductsSnapshot.docs.map((e){
      Map<String, dynamic> documentMap = e.data();
      documentMap['id'] = e.id;
      Product product = Product.fromMap(documentMap);
      return product;
    }).toList();
    return allCartProducts;
  }

  deleteCartProduct(String productId) async{
    String myid = FirebaseAuth.instance.currentUser.uid;
    await firebaseFirestore.collection('users').doc(myid).collection('cart').doc(productId).delete();
  }

  Future<List<Product>> getProductFromCategory(String catId) async{
    QuerySnapshot<Map<String, dynamic>> allProductsSnapshot =
    await firebaseFirestore.collection('products').where('categoryId', isEqualTo: catId).get();

    List<Product> allProducts = allProductsSnapshot.docs.map((e){
      Map<String, dynamic> documentMap = e.data();
      documentMap['id'] = e.id;
      Product product = Product.fromMap(documentMap);
      return product;
    }).toList();
    return allProducts;

  }

  // for Address

  addAddress(Address address) async {
    String myid = FirebaseAuth.instance.currentUser.uid;
    firebaseFirestore.collection('users').doc(myid).collection('address').add(address.toMap());
  }

  editAddress(Address newAddress) async{
    String myid = FirebaseAuth.instance.currentUser.uid;
    await firebaseFirestore.collection('users').doc(myid).collection('address').doc(newAddress.id).update(newAddress.toMap());
  }

  Future<List<Address>> getAllAddress() async{
    String myid = FirebaseAuth.instance.currentUser.uid;
    QuerySnapshot<Map<String, dynamic>> allAddressSnapshot =
    await firebaseFirestore.collection('users').doc(myid).collection('address').get();
    List<Address> allAdreess = allAddressSnapshot.docs.map((e){
      Map<String, dynamic> documentMap = e.data();
      documentMap['id'] = e.id;
      Address address = Address.fromMap(documentMap);
      return address;
    }).toList();
    return allAdreess;
  }

  deleteAddress(String addressId) async{
    String myid = FirebaseAuth.instance.currentUser.uid;
    await firebaseFirestore.collection('users').doc(myid).collection('address').doc(addressId).delete();
  }


}

