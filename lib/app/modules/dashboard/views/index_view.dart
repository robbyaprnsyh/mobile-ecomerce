import 'package:ecommerce/app/modules/kategori/views/kategori_view.dart';
import 'package:ecommerce/app/modules/produk/views/produk_view.dart';
import 'package:ecommerce/app/modules/subKategori/views/sub_kategori_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class IndexView extends GetView<DashboardController> {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_DashboardItem> items = [
      _DashboardItem(
        icon: Icons.inventory,
        title: 'Sub Kategori',
        color: Colors.green,
        page: const SubKategoriView(),
      ),
      _DashboardItem(
        icon: Icons.category,
        title: 'Kategori',
        color: Colors.teal,
        page: const KategoriView(),
      ),
      _DashboardItem(
        icon: Icons.shopping_bag,
        title: 'Produk',
        color: Colors.blue,
        page: const ProdukView(),
      ),
      _DashboardItem(
        icon: Icons.payment,
        title: 'Transaksi',
        color: Colors.redAccent,
        page: const KategoriView(), 
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 126, 184),
        elevation: 1,
        title: const Text(
          'SUKO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildDashboardCard(context, item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, _DashboardItem item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => item.page),
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: item.color.withOpacity(0.1),
                radius: 28,
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardItem {
  final IconData icon;
  final String title;
  final Color color;
  final Widget page;

  _DashboardItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.page,
  });
}
