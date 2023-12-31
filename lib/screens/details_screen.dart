import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/providers/home_provider.dart';
import 'package:car_wash_app/providers/details_screen_provider.dart';
import 'package:car_wash_app/screens/payment_method_screen.dart';

class PackageDetailScreen extends StatefulWidget {
  final Map<String, dynamic> package;

  const PackageDetailScreen({Key? key, required this.package})
      : super(key: key);

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  List<bool> additionalServices = List.generate(7, (index) => false);

  List<double> additionalServicePrices = [
    10.00,
    5.00,
    15.00,
    10.00,
    10.00,
    20.00,
    15.00,
  ];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    totalPrice = double.parse(widget.package["price"]);
  }

  ElevatedButton _buildServiceButton(int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          additionalServices[index] = !additionalServices[index];
          if (additionalServices[index]) {
            totalPrice += additionalServicePrices[index];
          } else {
            totalPrice -= additionalServicePrices[index];
          }
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          additionalServices[index] ? Colors.red : Colors.grey,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Text(
        _getServiceName(index),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  String _getServiceName(int index) {
    switch (index) {
      case 0:
        return "Interior Vacuum";
      case 1:
        return "Tire Dressing";
      case 2:
        return "Clay Bar";
      case 3:
        return "Window Cleaning";
      case 4:
        return "Chrome Shining";
      case 5:
        return "Interior Detail";
      case 6:
        return "Chairs Cleaning";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailScreenProvider =
        Provider.of<DetailScreenProvider>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.package["image"],
                fit: BoxFit.cover,
              ),
            ),
            leading: CupertinoNavigationBarBackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.package["service"]}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${widget.package["type"]}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              final homeScreenModel =
                                  Provider.of<HomeScreenProvider>(context,
                                      listen: false);

                              detailScreenProvider.toggleFavorite();

                              if (detailScreenProvider.isFavorite) {
                                homeScreenModel.addToFavorites(widget.package);
                              } else {
                                homeScreenModel
                                    .removeFromFavorites(widget.package);
                              }
                            },
                            child: Consumer<DetailScreenProvider>(
                              builder: (context, detailScreenProvider, _) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(14),
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: detailScreenProvider.isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Additional Services:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildServiceButton(0),
                              _buildServiceButton(1),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildServiceButton(2),
                              _buildServiceButton(3),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildServiceButton(4),
                              _buildServiceButton(5),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildServiceButton(6),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PaymentMethodScreen(
                                  totalPrice: totalPrice,
                                  selectedPackage: widget.package["service"],
                                  selectedCarType: widget.package["type"],
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 48),
                            ),
                          ),
                          child: Text(
                            "Go to Payment".toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
