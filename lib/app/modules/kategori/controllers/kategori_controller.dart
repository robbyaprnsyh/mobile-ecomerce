import 'package:ecommerce/app/data/kategori_response.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KategoriController extends GetxController {
  var isLoading = false.obs;
  var kategoriList = <DataKategori>[].obs;

  final _authStorage = GetStorage(); // Instance untuk membaca token

  @override
  void onInit() {
    super.onInit();
    fetchKategori();
  }

  // Fungsi untuk mendapatkan token dari GetStorage
  String? _getToken() {
    return _authStorage.read('auth_token'); // Tetap menggunakan 'auth_token'
  }

  Future<void> fetchKategori() async {
    final token = _getToken(); // Ambil token dari storage
    if (token == null) {
      Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
      return;
    }

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(BaseUrl.kategori),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final kategoriResponse = KategoriResponse.fromJson(jsonResponse);

        if (kategoriResponse.success == true) {
          kategoriList.assignAll(kategoriResponse.data ?? []);
        } else {
          Get.snackbar('Error', 'Data kategori tidak valid.');
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

  Future<void> addKategori(String name) async {
    final token = _getToken(); // Ambil token dari storage
    if (token == null) {
      Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
      return;
    }

    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(BaseUrl.kategori),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 201) {
        fetchKategori(); // refresh list
        Get.back(); // tutup modal/form
        Get.snackbar('Sukses', 'Kategori berhasil ditambahkan');
      } else {
        final res = json.decode(response.body);
        Get.snackbar('Error', res['message'] ?? 'Gagal menambahkan kategori');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> editKategori(int id, String name) async {
    final token = _getToken(); // Ambil token dari storage
    if (token == null) {
      Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
      return;
    }

    try {
      isLoading(true);
      final response = await http.put(
        Uri.parse('${BaseUrl.kategori}/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name}), // Proper JSON encoding
      );

      if (response.statusCode == 200) {
        fetchKategori();
        Get.back();
        Get.snackbar('Sukses', 'Kategori berhasil diupdate');
      } else {
        final res = json.decode(response.body);
        Get.snackbar('Error', res['message'] ?? 'Gagal mengupdate kategori');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteKategori(int id) async {
    final token = _getToken(); // Ambil token dari storage
    if (token == null) {
      Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
      return;
    }

    try {
      isLoading(true);
      final response = await http.delete(
        Uri.parse('${BaseUrl.kategori}/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        fetchKategori();
        Get.snackbar('Sukses', 'Kategori berhasil dihapus');
      } else {
        final res = json.decode(response.body);
        Get.snackbar('Error', res['message'] ?? 'Gagal menghapus kategori');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading(false);
    }
  }
}
