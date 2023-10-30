import 'package:flutter/material.dart';

import 'package:car_wash_app/screens/details_screen.dart';
import 'package:car_wash_app/providers/home_provider.dart';

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
      "image": "assets/images/sports01-car_wash_9_11zon.jpg",
      "service": "Bronze Package",
      "type": "Sport",
      "price": "10.00",
    },
    {
      "image": "assets/images/sports02-car_wash_8_11zon.jpg",
      "service": "Silver Package",
      "type": "Sport",
      "price": "15.00",
    },
    {
      "image": "assets/images/sports03-car_wash_7_11zon.jpg",
      "service": "Gold Package",
      "type": "Sport",
      "price": "20.00",
    },
    {
      "image": "assets/images/sports04-car_wash_6_11zon.jpeg",
      "service": "Platinum Package",
      "type": "Sport",
      "price": "35.00",
    },
    {
      "image": "assets/images/sedan01-car_wash_13_11zon.jpg",
      "service": "Bronze Package",
      "type": "Sedan",
      "price": "10.00",
    },
    {
      "image": "assets/images/sedan02-car_wash_12_11zon.jpg",
      "service": "Silver Package",
      "type": "Sedan",
      "price": "15.00",
    },
    {
      "image": "assets/images/sedan03-car_wash_11_11zon.jpg",
      "service": "Gold Package",
      "type": "Sedan",
      "price": "20.00",
    },
    {
      "image": "assets/images/sedan04-car_wash_10_11zon.jpg",
      "service": "Platinum Package",
      "type": "Sedan",
      "price": "35.00",
    },
    {
      "image": "assets/images/suv01-car_wash_5_11zon.jpg",
      "service": "Bronze Package",
      "type": "SUV",
      "price": "12.00",
    },
    {
      "image": "assets/images/suv03-car_wash_3_11zon.jpg",
      "service": "Silver Package",
      "type": "SUV",
      "price": "18.00",
    },
    {
      "image": "assets/images/suv04-car_wash_2_11zon.jpg",
      "service": "Gold Package",
      "type": "SUV",
      "price": "25.00",
    },
    {
      "image": "assets/images/suv05-car_wash_1_11zon.jpg",
      "service": "Platinum Package",
      "type": "SUV",
      "price": "40.00",
    },
    {
      "image": "assets/images/classic01-car_wash_15_11zon.jpg",
      "service": "Bronze Package",
      "type": "Classic",
      "price": "12.00",
    },
    {
      "image": "assets/images/classic02-car_wash_14_11zon.jpg",
      "service": "Silver Package",
      "type": "Classic",
      "price": "18.00",
    },
    {
      "image": "assets/images/classic01-car_wash_15_11zon.jpg",
      "service": "Gold Package",
      "type": "Classic",
      "price": "25.00",
    },
    {
      "image": "assets/images/classic02-car_wash_14_11zon.jpg",
      "service": "Platinum Package",
      "type": "Classic",
      "price": "40.00",
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
