import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce/app/data/subKategori_response.dart';
import 'package:ecommerce/app/utils/api.dart';

class SubKategoriController extends GetxController {
  var subKategoriList = <SubKategori>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchSubKategori();
    super.onInit();
  }

  Future<void> fetchSubKategori() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(BaseUrl.subKategori));
      
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        subKategoriList.value = jsonData
            .map((e) => SubKategori.fromJson(e))
            .toList();
      } else {
        Get.snackbar('Error', 'Gagal mengambil data sub kategori (${response.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading(false);
    }
  }
}
