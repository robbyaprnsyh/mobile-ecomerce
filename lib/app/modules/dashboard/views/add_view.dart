import 'package:ecommerce/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class AddView extends GetView {
  const AddView({super.key});
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Produk'),
        centerTitle: true,
        backgroundColor: HexColor('#feeee8'),
      ),
      backgroundColor: HexColor('#feeee8'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Lottie.asset(
              'assets/lottie/animation1.json',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Produk Name',
                hintText: 'Masukan Nama Produk',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: TextField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Masukan Deskripsi',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
