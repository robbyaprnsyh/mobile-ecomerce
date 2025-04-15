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
          child: GridView.builder(
            itemCount: controller.produkList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              final produk = controller.produkList[index];
              final imageList = produk.images ?? [];
              final imageUrl = imageList.isNotEmpty
                  ? 'http://192.168.207.83:8000/gambar_produk/${imageList[0]}'
                  : null;

              return GestureDetector(
                onTap: () => _showDetailDialog(context, produk),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: imageUrl != null
                            ? Image.network(
                                imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 120,
                                width: double.infinity,
                                color: Colors.blue.withOpacity(0.1),
                                child: const Icon(Icons.broken_image,
                                    size: 50, color: Colors.blue),
                              ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produk.namaProduk ?? '-',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Kategori: ${produk.kategori?.name ?? '-'}",
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Sub: ${produk.subKategori?.name ?? '-'}",
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                "Rp. ${NumberFormat('#,###', 'id_ID').format(produk.harga ?? 0)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
        ? 'http://192.168.207.83:8000/gambar_produk/${produk.images![0]}'
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
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image,
                              size: 50, color: Colors.grey),
                        ),
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
