import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/produk_controller.dart';

class ProdukView extends GetView<ProdukController> {
  const ProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.produkList.isEmpty) {
          return const Center(child: Text('Tidak ada produk'));
        }

        return ListView.builder(
          itemCount: controller.produkList.length,
          itemBuilder: (context, index) {
            final produk = controller.produkList[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  radius: 28,
                  child: const Icon(Icons.shopping_bag, color: Colors.blue),
                ),
                title: Text(produk.namaProduk ?? '-'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kategori: ${produk.kategori?.name ?? '-'}"),
                    Text("Sub Kategori: ${produk.subKategori?.name ?? '-'}"),
                  ],
                ),
                isThreeLine: true,
                trailing: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Get.defaultDialog(
                      title: produk.namaProduk ?? 'Detail Produk',
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text("Kategori: ${produk.kategori?.name ?? '-'}"),
                            Text("Sub Kategori: ${produk.subKategori?.name ?? '-'}"),
                            Text("Harga: Rp${produk.harga ?? '-'}"),
                            Text("Stok: ${produk.stok ?? '-'}"),
                            const SizedBox(height: 10),
                            const Text("Deskripsi:"),
                            Text(
                              produk.deskripsi?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '-',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
