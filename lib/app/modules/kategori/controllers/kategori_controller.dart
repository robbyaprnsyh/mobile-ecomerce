import 'package:ecommerce/app/data/kategori_response.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KategoriController extends GetxController {
  var isLoading = false.obs;
  var kategoriList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKategori();
  }

  Future<void> fetchKategori() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(BaseUrl.kategori));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final kategoriResponse = KategoriResponse.fromJson(jsonResponse);

        if (kategoriResponse.success == true) {
          kategoriList.assignAll(kategoriResponse.data ?? []);
        } else {
          Get.snackbar('Error', 'Gagal memuat kategori');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading(false);
    }
  }
}
