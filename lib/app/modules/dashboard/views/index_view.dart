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
        color: Colors.red,
        page: const KategoriView(), 
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF007EB8),
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth < 600
              ? 2
              : constraints.maxWidth < 900
                  ? 3
                  : 4;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return _buildDashboardCard(context, items[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, _DashboardItem item) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => item.page),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: item.color.withOpacity(0.12),
                radius: 32,
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 30,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[800],
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
