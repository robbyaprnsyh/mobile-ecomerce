// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../controllers/profile_controller.dart';

// class ProfileView extends GetView<ProfileController> {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final storage = GetStorage();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profil Saya'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               controller.logout();
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final userId = int.tryParse(storage.read('user_id').toString());

//         if (userId == null) {
//           return const Center(child: Text("ID user tidak valid."));
//         }

//         final user = controller.getUserById(userId);

//         if (user == null) {
//           return const Center(child: Text("Data user tidak ditemukan."));
//         }

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(
//                   'http://192.168.80.83:8000/storage/${user.profile}',
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 user.name ?? '-',
//                 style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               Text(user.email ?? '-', style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Chip(
//                 label: Text(user.status ?? 'Tidak diketahui'),
//                 backgroundColor:
//                     user.status == 'aktif' ? Colors.green : Colors.red,
//                 labelStyle: const TextStyle(color: Colors.white),
//               ),
//               const Spacer(),
//               ElevatedButton.icon(
//                 onPressed: () => controller.logout(),
//                 icon: const Icon(Icons.logout),
//                 label: const Text('Logout'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 ),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
