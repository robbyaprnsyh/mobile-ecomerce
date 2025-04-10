import 'package:ecommerce/app/modules/kategori/views/kategori_view.dart';
import 'package:ecommerce/app/modules/produk/views/produk_view.dart';
import 'package:ecommerce/app/modules/profile/views/profile_view.dart';
import 'package:ecommerce/app/modules/subKategori/views/sub_kategori_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class IndexView extends GetView<DashboardController> {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SUKO',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 126, 184),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat datang di SUKO!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, 
                crossAxisSpacing: 8,
                mainAxisSpacing: 8, 
                children: [
                  _buildDashboardCard(
                    context,
                    icon: Icons.inventory,
                    title: 'Sub Kategori',
                    color: Colors.greenAccent,
                    page: const SubKategoriView(),
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.category,
                    title: 'Kategori',
                    color: Color.fromARGB(255, 57, 119, 125),
                    page:  const KategoriView(),
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.shopping_bag,
                    title: 'Produk',
                    color: Color.fromARGB(255, 0, 126, 184),
                    page: const ProdukView(),
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.payment,
                    title: 'Transaksi',
                    color: Color.fromARGB(255, 201, 55, 41),
                    page: const KategoriView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
