import 'package:flutter/material.dart';

import 'package:car_wash_app/screens/details_screen.dart';
import 'package:car_wash_app/providers/home_screen_provider.dart';

class RecomendCard extends StatefulWidget {
  final Category selectedCategory;

  const RecomendCard({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  State<RecomendCard> createState() => _RecomendCardState();
}

class _RecomendCardState extends State<RecomendCard> {
  List<Map<String, dynamic>> recmcard = [
    {
      "image": "assets/images/carwash_1.png",
      "service": "Bronze Package",
      "type": "Sport",
      "price": "10.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Silver Package",
      "type": "Sport",
      "price": "15.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Gold Package",
      "type": "Sport",
      "price": "20.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Platinum Package",
      "type": "Sport",
      "price": "35.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Bronze Package",
      "type": "Sedan",
      "price": "10.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Silver Package",
      "type": "Sedan",
      "price": "15.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Gold Package",
      "type": "Sedan",
      "price": "20.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Platinum Package",
      "type": "Sedan",
      "price": "35.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Bronze Package",
      "type": "SUV",
      "price": "10.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Silver Package",
      "type": "SUV",
      "price": "15.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Gold Package",
      "type": "SUV",
      "price": "20.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Platinum Package",
      "type": "SUV",
      "price": "35.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Bronze Package",
      "type": "Classic",
      "price": "10.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Silver Package",
      "type": "Classic",
      "price": "15.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Gold Package",
      "type": "Classic",
      "price": "20.0",
    },
    {
      "image": "assets/images/carwash_1.png",
      "service": "Platinum Package",
      "type": "Classic",
      "price": "35.0",
    },
  ];

  List<Map<String, dynamic>> getFilteredPackages(Category category) {
    return recmcard
        .where((package) =>
            widget.selectedCategory == Category.all ||
            package['type'].toString().toLowerCase() ==
                widget.selectedCategory.toString().split('.').last)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: getFilteredPackages(widget.selectedCategory).length,
      itemBuilder: ((context, index) {
        final package = getFilteredPackages(widget.selectedCategory)[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PackageDetailScreen(package: package),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(package["image"]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package["service"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.directions_car),
                          Text(
                            package["type"],
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
