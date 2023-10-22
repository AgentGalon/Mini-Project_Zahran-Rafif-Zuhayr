// import 'package:flutter/material.dart';

// class ServiceCard extends StatefulWidget {
//   const ServiceCard({Key? key}) : super(key: key);

//   @override
//   State<ServiceCard> createState() => _ServiceCardState();
// }

// class _ServiceCardState extends State<ServiceCard> {
//   List<Map<String, dynamic>> washcard = [
//     {"icon": Icons.directions_car, "type": "All "},
//     {"icon": Icons.directions_car, "type": "Sport "},
//     {"icon": Icons.directions_car, "type": "Sedan "},
//     {"icon": Icons.directions_car, "type": "SUV "},
//     {"icon": Icons.directions_car, "type": "Classic "},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: washcard.length,
//         itemBuilder: ((context, index) {
//           return Card(
//             shape: RoundedRectangleBorder(
//               side: const BorderSide(color: Colors.black, width: 2.0),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             color: Colors.white,
//             elevation: 1,
//             child: InkWell(
//               onTap: () {},
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   children: [
//                     Icon(
//                       washcard[index]["icon"],
//                       size: 50,
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       washcard[index]["type"],
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
