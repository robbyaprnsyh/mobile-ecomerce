import 'dart:async';
import 'package:ecommerce/app/modules/login/views/login_view.dart';
import 'package:ecommerce/app/modules/dashboard/views/dashboard_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
          Get.off(
            () => const LoginView(),
            transition: Transition.leftToRight,
          );
        } else {
          Get.off(
            () => const DashboardView(),
            transition: Transition.leftToRight,
          );
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
