import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  late Timer _pindah;
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _pindah = Timer(
      const Duration(seconds: 4),
      () {
        if (authToken.read('token') == null) {
          Get.offNamed(Routes.LOGIN); 
        } else {
          Get.offNamed(Routes.DASHBOARD); 
        }
      },
    );
  }

  @override
  void onClose() {
    _pindah.cancel();
    super.onClose();
  }
}
