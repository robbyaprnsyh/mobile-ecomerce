import 'dart:convert';
import 'package:ecommerce/app/data/profile_response.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var userList = <Users>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);

      final response = await http.get(Uri.parse(BaseUrl.profile));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final profileResponse = ProfileResponse.fromJson(data);
        userList.value = profileResponse.users ?? [];
      } else {
        Get.snackbar("Gagal", "Status Code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data user: $e");
    } finally {
      isLoading(false);
    }
  }

  Users? getUserById(int id) {
    return userList.firstWhereOrNull((u) => u.id == id);
  }

  void logout() async {
    final token = GetStorage().read('auth_token');

    final response = await GetConnect().post(
      BaseUrl.logout,
      {},
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      GetStorage().erase();
      Get.offAllNamed('/login');
    } else {
      Get.snackbar('Gagal', 'Logout gagal: ${response.statusText}');
    }
  }
}
