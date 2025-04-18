import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/produk_controller.dart';

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
              final imageList = produk.images ?? [];
              final imageUrl = imageList.isNotEmpty
                  ? 'http://192.168.0.213:8000/gambar_produk/${imageList[0]}'
                  : null;

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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            color: Colors.blue.withOpacity(0.1),
                            child: const Icon(Icons.shopping_bag,
                                color: Colors.blue),
                          ),
                  ),
                  title: Text(
                    produk.namaProduk ?? '-',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kategori: ${produk.kategori?.name ?? '-'}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                        "Sub: ${produk.subKategori?.name ?? '-'}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                        "Harga: Rp. ${NumberFormat('#,###', 'id_ID').format(produk.harga ?? 0)}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.green),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon:
                        const Icon(Icons.visibility, color: Color(0xFF007EB8)),
                    onPressed: () => _showDetailDialog(context, produk),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  void _showDetailDialog(BuildContext context, dynamic produk) {
    final imageUrl = (produk.images?.isNotEmpty ?? false)
        ? 'http://192.168.152.83:8000/gambar_produk/${produk.images![0]}'
        : null;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 200,
                      color: Colors.blue.withOpacity(0.1),
                      child: const Center(
                        child: Icon(Icons.broken_image,
                            size: 50, color: Colors.blue),
                      ),
                    ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  produk.namaProduk ?? '-',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF007EB8),
                  ),
                ),
              ),
              const Divider(height: 24, color: Colors.grey),
              _buildDetailItem("Kategori", produk.kategori?.name),
              _buildDetailItem("Sub Kategori", produk.subKategori?.name),
              _buildDetailItem(
                "Harga",
                "Rp. ${NumberFormat('#,###', 'id_ID').format(produk.harga ?? 0)}",
              ),
              _buildDetailItem("Stok", "${produk.stok ?? 0}"),
              const SizedBox(height: 12),
              const Text("Deskripsi:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(
                produk.deskripsi?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '-',
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007EB8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text("Tutup"),
                ),
              )
            ],
          ),
        ),
      ),
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
