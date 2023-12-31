import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/screens/chatbot_screen.dart';
import 'package:car_wash_app/screens/profile_screen.dart';
import 'package:car_wash_app/widgets/bottom_nav_bar.dart';
import 'package:car_wash_app/screens/favorite_screen.dart';
import 'package:car_wash_app/providers/login_provider.dart';
import 'package:car_wash_app/screens/notification_screen.dart';
import 'package:car_wash_app/widgets/featured_packages_card.dart';
import 'package:car_wash_app/providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeScreenModel =
        Provider.of<HomeScreenProvider>(context, listen: false);
    int currentIndex = homeScreenModel.currentIndex;

    void onTabTapped(int index) {
      homeScreenModel.setTabIndex(index);
    }

    return Scaffold(
      body: currentIndex == 0
          ? _buildHomeContent()
          : currentIndex == 1
              ? const FavoriteScreen()
              : currentIndex == 2
                  ? const ChatBotScreen()
                  : currentIndex == 3
                      ? const ProfileScreen()
                      : const Placeholder(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }

  Widget _buildHomeContent() {
    var size = MediaQuery.of(context).size;
    var height = size.height;

    final homeScreenModel = Provider.of<HomeScreenProvider>(context);
    final username = Provider.of<AuthProvider>(context).username;

    Category selectedCategory = homeScreenModel.selectedCategory;

    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        top: 15,
        right: 15,
        bottom: 4,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, $username",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "What do you need \nhelp with today?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 1.5,
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                      ),
                      alignment: Alignment.topRight,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: height * 0.058,
                    child: TextField(
                      cursorColor: Colors.white54,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Search for service',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 18,
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton("All", Category.all),
                    _buildCategoryButton("Sport", Category.sport),
                    _buildCategoryButton("Sedan", Category.sedan),
                    _buildCategoryButton("SUV", Category.suv),
                    _buildCategoryButton("Classic", Category.classic),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Text(
                  "Featured Packages",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: RecomendCard(
                selectedCategory: selectedCategory,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, Category category) {
    final homeScreenModel = Provider.of<HomeScreenProvider>(context);

    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ElevatedButton(
        onPressed: () {
          homeScreenModel.setSelectedCategory(category);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            homeScreenModel.selectedCategory == category
                ? Colors.red
                : Colors.white,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: homeScreenModel.selectedCategory == category
                ? Colors.white
                : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
