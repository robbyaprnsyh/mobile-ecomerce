import 'package:get/get.dart';

import '../controllers/sub_kategori_controller.dart';

class SubKategoriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubKategoriController>(
      () => SubKategoriController(),
    );
  }
}
