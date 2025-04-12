import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/produk_controller.dart';
import 'package:intl/intl.dart';

class ProdukView extends GetView<ProdukController> {
  const ProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        centerTitle: true,
        backgroundColor: const Color(0xFF007EB8),
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.produkList.isEmpty) {
          return const Center(
            child: Text(
              'Tidak ada produk',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: controller.produkList.length,
            itemBuilder: (context, index) {
              final produk = controller.produkList[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    child: const Icon(Icons.shopping_bag, color: Colors.blue),
                  ),
                  title: Text(
                    produk.namaProduk ?? '-',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kategori: ${produk.kategori?.name ?? '-'}"),
                        Text(
                            "Sub Kategori: ${produk.subKategori?.name ?? '-'}"),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    produk.namaProduk ?? 'Detail Produk',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF007EB8),
                                    ),
                                  ),
                                ),
                                const Divider(height: 20, color: Colors.grey),
                                const SizedBox(height: 8),
                                _buildDetailItem(
                                    "Kategori", produk.kategori?.name),
                                _buildDetailItem(
                                    "Sub Kategori", produk.subKategori?.name),
                                _buildDetailItem(
                                    "Harga", "Rp${produk.harga ?? '-'}"),
                                _buildDetailItem(
                                    "Stok", "${produk.stok ?? '-'}"),
                                const SizedBox(height: 12),
                                const Text("Deskripsi:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                                const SizedBox(height: 4),
                                Text(
                                  produk.deskripsi?.replaceAll(
                                          RegExp(r'<[^>]*>'), '') ??
                                      '-',
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildDetailItem(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: "$title: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: value ?? "-",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
