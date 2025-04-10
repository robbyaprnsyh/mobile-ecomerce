import 'package:ecommerce/app/modules/kategori/controllers/kategori_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KategoriController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kategori'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.kategoriList.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          }
          return ListView.builder(
            itemCount: controller.kategoriList.length,
            itemBuilder: (context, index) {
              final kategori = controller.kategoriList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(kategori.name ?? '-'),
                  subtitle: Text('Dibuat: ${kategori.createdAt}'),
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
