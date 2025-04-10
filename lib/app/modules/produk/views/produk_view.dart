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
            final imageUrl = produk.images?.isNotEmpty == true ? produk.images!.first : null;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image, size: 60),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                        ),
                      )
                    : const Icon(Icons.image, size: 60),
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
