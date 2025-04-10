import 'package:ecommerce/app/data/produk_response.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:get/get.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;

class ProdukController extends GetxController {
  var produkList = <ProdukResponse>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduk(); 
  }

  Future<void> fetchProduk() async {
    try {
      isLoading(true);

      final response = await http.get(Uri.parse(BaseUrl.produk));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        var produk = jsonData.map((item) => ProdukResponse.fromJson(item)).toList();
        produkList.value = produk;
      } else {
        print("Gagal fetch produk: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    } finally {
      isLoading(false);
    }
  }
}
