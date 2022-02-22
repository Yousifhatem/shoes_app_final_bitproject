import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/firestore_helper/auth_helper.dart';
import 'package:shop_app_final/controller/controller/firestore_helper/firestore_helper.dart';
import 'package:shop_app_final/core/const.dart';
import 'package:shop_app_final/model/category.dart';
import 'package:shop_app_final/model/fir_user.dart';
import 'package:shop_app_final/model/product.dart';
import 'package:shop_app_final/pages/my_screens/address_screen.dart';
import 'package:shop_app_final/pages/my_screens/home_page.dart';
import 'package:shop_app_final/pages/my_screens/login_screen.dart';
import 'package:shop_app_final/pages/my_screens/spicific_product.dart';
import 'package:shop_app_final/widgets/app_clipper.dart';
import 'package:string_validator/string_validator.dart';

import '../../../constants.dart';
import '../../../model/address.dart';
import '../../../pages/my_screens/bottom_navigaion_screen.dart';
import '../router_helper.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    getAllProducts();
    getAllCategories();
    getAllCartProducts();
    getAllFavoriteProducts();
    getAllAddress();
  }

  FireUser loggedFireUser;
  File file;

  String categoryImageUrl;
  String productImageUrl;
  String imageUrlUser;
  bool isFavorite = false;

  List<Product> allProducts;
  List<Category> allCategories;
  List<Product> allProductsFromCategory;
  List<Product> spacificProducts;
  List<Product> cartProducts;
  List<Product> FavoriteProducts;
  List<Address> allAdress;


  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryDescriptionController = TextEditingController();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();


  TextEditingController addressNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();


  TextEditingController priceController = TextEditingController();
  TextEditingController numberCardController = TextEditingController();


  List<String> brands = ['None', 'Nike', 'Converse', 'Black Nike'];
  String selectedBrands = 'None';
  String selectedAddress = '';

  bool isLoading = false;
  bool isPopular = false;

  ImageSource imageSource;
  int selectedColor = 0;

  getAddNumOfCount(int count){
    count++;
    notifyListeners();
  }

  getRemoveNumOfCount(int count){
    if(count>1) {
      count--;
    }
    notifyListeners();
  }

  changeFavProduct(){
    isFavorite != isFavorite;
    notifyListeners();
  }


  SnackBar snackBar = const SnackBar(
    content: Text('Enter All Field!'),
    backgroundColor: Colors.red,
  );

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addAddressFormKey = GlobalKey<FormState>();


  selectSource(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              'Select the image source :',
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        imageSource = ImageSource.camera;
                        pickNewImage();
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Image.asset(
                          'assets/camera.png',
                          fit: BoxFit.cover,
                          width: 100.w,
                          height: 100.h,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        imageSource = ImageSource.gallery;
                        pickNewImage();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        // decoration: BoxDecoration(
                        //     border: Border.all(width: 0.5,color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(15),
                        //     color: Colors.transparent
                        // ),
                        child: Image.asset(
                          'assets/gallery.png',
                          fit: BoxFit.cover,
                          width: 100.w,
                          height: 100.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  pickNewImage() async {
    XFile file = await ImagePicker().pickImage(source: imageSource);
    this.file = File(file.path);
    notifyListeners();
  }

  register(FireUser fireUser, BuildContext context) async {
    bool isSuccess = registerFormKey.currentState.validate();
    if (isSuccess) {
      registerFormKey.currentState.save();
      try {
        String userId = await AuthHelper.authHelper
            .createNewAccount(fireUser.email.trim(), fireUser.password.trim());
        fireUser.id = userId;
        String imageUrl = await FireStoreHelper.fireStoreHelper.uploadImage(file);
        fireUser.imageUser = imageUrl;
        await FireStoreHelper.fireStoreHelper.createUserInFs(fireUser);
        loggedFireUser = fireUser;
        RouterHelper.routerHelper
            .routingToSpecificWidgetWithoutPop(HomePage());
        clear();

      } on Exception catch (e) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString().split(']').last),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  login(String email, String password, BuildContext context) async {
    bool isSuccess = loginFormKey.currentState.validate();
    if (isSuccess) {
      loginFormKey.currentState.save();
      try {
        UserCredential userCredential =
            await AuthHelper.authHelper.signIn(email.trim(), password.trim());
        await getUserFromFirebase();
        RouterHelper.routerHelper
            .routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
      } on Exception catch (e) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString().split(']').last),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  getUserFromFirebase() async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    loggedFireUser =
        await FireStoreHelper.fireStoreHelper.getUserFromFirebase(userId);
    notifyListeners();
  }

  editUser(String userId) async {
    if (file != null) {
      imageUrlUser = await FireStoreHelper.fireStoreHelper.uploadImage(file);
    } else {
      FireUser user = FireUser(
        id: userId,
        name: userNameController.text,
        address: userAddressController.text,
        phone: userPhoneController.text,
        email: userEmailController.text,
        password: userPasswordController.text,
      );
      user.imageUser = imageUrlUser;
      await FireStoreHelper.fireStoreHelper.editUser(user);
      //Navigator.of(RouterHelper.routerHelper.routerKey.currentState.context).pop();
    }
  }

  goToEditUser(FireUser user) async {
    file = null;
    userNameController.text = user.name;
    userAddressController.text = user.address;
    userPhoneController.text = user.phone;
    userEmailController.text = user.email;
    userPasswordController.text = user.password;
    imageUrlUser = user.imageUser;
    notifyListeners();
  }

  logout() async {
    loggedFireUser = null;
    await AuthHelper.authHelper.logout();
    RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(LoginScreen());
  }

  // for category
  addCategory(BuildContext context) async {
    bool isSuccess = addProductFormKey.currentState.validate();
    if (isSuccess) {
      addProductFormKey.currentState.save();
      String imageUrl = await FireStoreHelper.fireStoreHelper.uploadImage(file);
      Category category = Category(
        name: categoryNameController.text,
        description: categoryDescriptionController.text,
        color: selectedColor,
        brand: selectedBrands,
      );
      category.imageUrl = imageUrl;
      await FireStoreHelper.fireStoreHelper.addNewCategory(category);
      getAllCategories();
      RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(HomePage());
      clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  editCategory(String categoryId) async {
    if (file != null) {
      categoryImageUrl = await FireStoreHelper.fireStoreHelper.uploadImage(file);
    } else {
      Category category = Category(
        id: categoryId,
        name: categoryNameController.text,
        description: categoryDescriptionController.text,
      );
      category.imageUrl = categoryImageUrl;
      await FireStoreHelper.fireStoreHelper.editCategory(category);
      getAllCategories();
      Navigator.of(RouterHelper.routerHelper.routerKey.currentState.context)
          .pop();
    }
  }

  goToEditCategory(Category category) async {
    file = null;
    categoryNameController.text = category.name;
    categoryDescriptionController.text = category.description;
    categoryImageUrl = category.imageUrl;
    notifyListeners();
    // RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddNewProduct(
    //   isForEdit: true,
    //   productId: product.id,
    // ));
  }

  getAllCategories() async {
    allCategories = await FireStoreHelper.fireStoreHelper.getAllCategory();
    notifyListeners();
  }

  deleteCategory(String categoryId) async {
    await FireStoreHelper.fireStoreHelper.deleteCategory(categoryId);
    getAllCategories();
  }

  // for product

  getProductFromCategory(String categoryId) async{
    spacificProducts = await FireStoreHelper.fireStoreHelper.getProductFromCategory(categoryId);
    notifyListeners();
  }

  addProduct(BuildContext context, String categoryId) async {
    bool isSuccess = addProductFormKey.currentState.validate();
    if (isSuccess) {
      addProductFormKey.currentState.save();
      String imageUrl = await FireStoreHelper.fireStoreHelper.uploadImage(file);
      Product product = Product(
        categoryId: categoryId,
        name: productNameController.text,
        description: productDescriptionController.text,
        price: num.parse(productPriceController.text),
        color: selectedColor,
        brand: selectedBrands,
        isPopular: isPopular,
      );
      product.imageUrl = imageUrl;
      await FireStoreHelper.fireStoreHelper.addNewProduct(product);
      getAllProducts();
      RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(HomePage());
      clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  editProduct(String productId) async {
    if (file != null) {
      productImageUrl = await FireStoreHelper.fireStoreHelper.uploadImage(file);
    } else {
      Product product = Product(
          id: productId,
          name: productNameController.text,
          description: productDescriptionController.text,
          price: num.parse(productPriceController.text),
          color: selectedColor,
          brand: selectedBrands,
          isPopular: isPopular,);

      product.imageUrl = productImageUrl;
      await FireStoreHelper.fireStoreHelper.editProduct(product);
      getAllProducts();
      Navigator.of(RouterHelper.routerHelper.routerKey.currentState.context)
          .pop();
    }
  }

  goToEditProduct(Product product) async {
    file = null;
    productNameController.text = product.name;
    productDescriptionController.text = product.description;
    productPriceController.text = product.price.toString();
    productImageUrl = product.imageUrl;
    notifyListeners();
    // RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddNewProduct(
    //   isForEdit: true,
    //   productId: product.id,
    // ));
  }

  getAllProducts() async {
    allProducts = await FireStoreHelper.fireStoreHelper.getAllProducts();
    notifyListeners();
  }

  deleteProduct(String productId) async {
    await FireStoreHelper.fireStoreHelper.deleteProduct(productId);
    getAllProducts();
  }


  getAllCartProducts() async {
    cartProducts = await FireStoreHelper.fireStoreHelper.getAllCartProducts();
    notifyListeners();
  }

  deleteCartProduct(String productId) async {
    await FireStoreHelper.fireStoreHelper.deleteCartProduct(productId);
    getAllCartProducts();
  }
  addProductToCartProduct(Product product) async {
    await  FireStoreHelper.fireStoreHelper.addProductToCart(product);
    getAllCartProducts();
  }
  addFavoiriteProduct(Product product) async{
    Product product1=await FireStoreHelper.fireStoreHelper.getOneProduct(product.id);
    await FireStoreHelper.fireStoreHelper.addProductToFavorite(product1);
    getAllFavoriteProducts();

  }
  deleteFavoiriteProduct(String productId) async{
    await FireStoreHelper.fireStoreHelper.deleteProductToFavorite(productId);
    getAllFavoriteProducts();

  }

  getAllFavoriteProducts() async {
    FavoriteProducts = await FireStoreHelper.fireStoreHelper.getAllFavoriteProducts();
    notifyListeners();
  }

  addAddress(BuildContext context) async {
    bool isSuccess = addAddressFormKey.currentState.validate();
    if (isSuccess) {
      addAddressFormKey.currentState.save();
      Address address = Address(
        addressName: addressNameController.text,
        street: streetController.text,
        cityName: cityController.text,
        zipCode: int.parse(zipCodeController.text),
      );
      await FireStoreHelper.fireStoreHelper.addAddress(address);
        getAllAddress();
      clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  editAddress(String addressId) async {

    Address address = Address(
      id: addressId,
      addressName: addressNameController.text,
      street: streetController.text,
      cityName: cityController.text,
      zipCode: int.parse(zipCodeController.text),
    );
      await FireStoreHelper.fireStoreHelper.editAddress(address);
      getAllAddress();
    clear();
    RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddressScreen());
  }

  goToEditAdreess(Address address) async {
    addressNameController.text = address.addressName;
    streetController.text = address.street;
    cityController.text = address.cityName;
    zipCodeController.text = address.zipCode.toString();
    notifyListeners();
  }

  getAllAddress() async {
    allAdress = await FireStoreHelper.fireStoreHelper.getAllAddress();
    notifyListeners();
  }

  deleteAddress(String addressId) async {
    await FireStoreHelper.fireStoreHelper.deleteAddress(addressId);
    getAllAddress();
  }


  clear() {
    file = null;
    categoryImageUrl = null;
    productImageUrl = null;
    imageUrlUser = null;
    categoryNameController.text = '';
    categoryDescriptionController.text = '';
    productNameController.text = '';
    productDescriptionController.text = '';
    productPriceController.text = '';
    userNameController.text = '';
    userAddressController.text = '';
    userPhoneController.text = '';
    userEmailController.text = '';
    userPasswordController.text = '';
    addressNameController.text = '';
    streetController.text = '';
    cityController.text = '';
    zipCodeController.text = '';

    notifyListeners();
  }



  Column colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8.h,
        ),
        Wrap(
          // تاخذ خصائص الrow او ال column حسب الdirection المحدد
          direction: Axis.horizontal,
          children: List.generate(
            9,
            (index) => GestureDetector(
              // توليد العناصر بشكل ديناميكي
              onTap: () {
                selectedColor = index;
                notifyListeners();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: CircleAvatar(
                  child: selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: index == 0
                      ? AppColors.orangeColor
                      : index == 1
                          ? AppColors.greenColor
                          : index == 2
                              ? darkGreyClr
                              : index == 3
                                  ? product4Color
                                  : index == 4
                                      ? product5Color
                                      : index == 5
                                          ? AppColors.blueColor
                                          : index == 6
                                              ? AppColors.redColor
                                              : index == 7
                                                  ? AppColors.yellowColor
                                                  : product6Color,
                  radius: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getBGClr(int color) {
    switch (color) {
      case 0:
        return AppColors.orangeColor;
      case 1:
        return AppColors.greenColor;
      case 2:
        return darkGreyClr;
      case 3:
        return product4Color;
      case 4:
        return product5Color;
      case 5:
        return AppColors.blueColor;
      case 6:
        return AppColors.redColor;
      case 7:
        return AppColors.yellowColor;
      default:
        return product6Color;
    }
  }

  getBGClrWithOpacity(int color) {
    switch (color) {
      case 0:
        return AppColors.orangeColor.withOpacity(0.1);
      case 1:
        return AppColors.greenColor.withOpacity(0.1);
      case 2:
        return darkGreyClr.withOpacity(0.1);
      case 3:
        return product4Color.withOpacity(0.1);
      case 4:
        return product5Color.withOpacity(0.1);
      case 5:
        return AppColors.blueColor.withOpacity(0.1);
      case 6:
        return AppColors.redColor.withOpacity(0.1);
      case 7:
        return AppColors.yellowColor.withOpacity(0.1);
      default:
        return product6Color.withOpacity(0.1);
    }
  }

  getBGClrWithOpacityForBorder(int color) {
    switch (color) {
      case 0:
        return AppColors.orangeColor.withOpacity(0.7);
      case 1:
        return AppColors.greenColor.withOpacity(0.7);
      case 2:
        return darkGreyClr.withOpacity(0.7);
      case 3:
        return product4Color.withOpacity(0.7);
      case 4:
        return product5Color.withOpacity(0.7);
      case 5:
        return AppColors.blueColor.withOpacity(0.7);
      case 6:
        return AppColors.redColor.withOpacity(0.7);
      case 7:
        return AppColors.yellowColor.withOpacity(0.7);
      default:
        return product6Color.withOpacity(0.7);
    }
  }

  Widget buildBackground(int index, double width, Function function, String categoryId) {
    return ClipPath(
      clipper: AppClipper(cornerSize: 25, diagonalHeight: 100.h),
      child: GestureDetector(
        onTap: () {
          getProductFromCategory(categoryId);
           RouterHelper.routerHelper.routingToSpecificWidget(const SpisificProductScreen());
        },
        child: Container(
          color: getBGClr(allCategories[index].color),
          width: width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0.h),
                      child: Icon(
                        allCategories[index].brand == "Nike"
                            ? Icons.done
                            : Icons.stars,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(
                      width: 125.0.w,
                      child: Text(allCategories[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(allCategories[index].description,
                        style: const TextStyle(
                          color: Colors.white,
                        )),

                    // Text(
                    //   "\$${allProducts[index].price}",
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(
                      height: 16.0.h,
                    ),
                  ],
                ),
              ),
              Consumer<AppProvider>(
                builder: (context, provider, x) {
                  return Visibility(
                    visible: provider.loggedFireUser?.isAdmin ?? false,
                    child: Positioned(
                      bottom: 0.h,
                      right: 0.w,
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {
                              function();
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddImageContainer({int index, double width, Function function}) {
    return ClipPath(
      clipper: AppClipper(cornerSize: 25, diagonalHeight: 100.h),
      child: Container(
        color: getBGClr(selectedColor),
        width: width,
        child: Stack(
          children: [
            Consumer<AppProvider>(
              builder: (context, provider, x) {
                return Positioned(
                  bottom: 0.h,
                  right: 0.w,
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          function();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String nullValidator(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  String nullAddProductValidator(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  emailValidation(String value) {
    if (!isEmail(value)) {
      return 'InCorrect Email syntax';
    }
  }

  String passworsdValidator(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    } else if (value.length < 6) {
      return 'Password too short!';
    }
    return null;
  }
}
