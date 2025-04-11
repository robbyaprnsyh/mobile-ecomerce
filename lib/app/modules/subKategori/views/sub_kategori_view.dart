import 'package:ecommerce/app/modules/subKategori/controllers/sub_kategori_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubKategoriView extends GetView<SubKategoriController> {
  const SubKategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubKategoriController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Kategori'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.subKategoriList.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          }
          return ListView.builder(
            itemCount: controller.subKategoriList.length,
            itemBuilder: (context, index) {
              final subKategori = controller.subKategoriList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    child: const Icon(Icons.inventory, color: Colors.green),
                  ),
                  title: Text(subKategori.name ?? '-'),
                  subtitle: Text('Kategori: ${subKategori.kategori?.name ?? '-'}'),
                  // onTap: () {
                  //   Get.snackbar('Info', 'Anda memilih ${subKategori.name}');
                  // },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
