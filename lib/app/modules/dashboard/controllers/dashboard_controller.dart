import 'package:ecommerce/app/data/produk_response.dart';
import 'package:ecommerce/app/modules/dashboard/views/index_view.dart';
import 'package:ecommerce/app/modules/dashboard/views/produk.dart';
import 'package:ecommerce/app/modules/dashboard/views/profile_view.dart';
import 'package:ecommerce/app/modules/produk/views/produk_view.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');
  var selectedIndex = 0.obs;

  Future<ProdukResponse> getProduk() async {
    final response = await _getConnect.get(
      BaseUrl.produk,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return ProdukResponse.fromJson(response.body);
  }

  var yourProduk = <ProdukResponse>[].obs;

TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

void addProduk() async {
  final response = await _getConnect.post(
    BaseUrl.produk,
    {
      'name': nameController.text,
      'description': descriptionController.text,
    },
    headers: {'Authorization': "Bearer $token"},
    contentType: "application/json",
  );

  if (response.statusCode == 201) {
    Get.snackbar(
      'Success',
      'Produk Added',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    nameController.clear();
    descriptionController.clear();
    update();
    getProduk();
    Get.close(1);
  } else {
    Get.snackbar(
      'Failed',
      'Produk Failed to Add',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    Produk(),
    ProfileView(),
  ];

  @override
  void onInit() {
    getProduk();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}