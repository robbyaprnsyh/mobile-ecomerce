import 'package:ecommerce/app/modules/produk/controllers/produk_controller.dart';
import 'package:ecommerce/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  Get.put(ProdukController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SUKO",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
    ),
  );
}
