import 'package:ecommerce/app/modules/produk/controllers/produk_controller.dart';
import 'package:ecommerce/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ProdukController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SUKO",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
    ),
  );
}