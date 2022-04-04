// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:learn_a_flower_app/models/flower.dart';
// import 'package:learn_a_flower_app/services/flower_service.dart';
//TODO:
// class AdminFlowerList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Database.readItems(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Something went wrong');
//         } else if (snapshot.hasData || snapshot.data != null) {
//           return ListView.separated(
//             separatorBuilder: (context, index) => const SizedBox(height: 16.0),
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               // Flower currentModel = snapshot.data![index];
//
//
//               return Ink(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   // onTap: () => Navigator.of(context).push(
//                   //   MaterialPageRoute(
//                   //     builder: (context) => EditScreen(
//                   //       currentTitle: title,
//                   //       currentDescription: description,
//                   //       documentId: docID,
//                   //     ),
//                   //   ),
//                   // ),
//                   title: Text(
//                    ' currentModel.flowerName',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   subtitle: Text(
//                     'description',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//
//         return const Center(
//           child: const CircularProgressIndicator(
//             valueColor: const AlwaysStoppedAnimation<Color>(
//               Colors.orange,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
