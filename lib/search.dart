import 'package:firebase/Adidasmenshoes.dart';
import 'package:firebase/Womenclothing.dart';
import 'package:firebase/Womenshoes.dart';
import 'package:firebase/kidsclothing.dart';
import 'package:firebase/kidsshoes.dart';
import 'package:flutter/material.dart';

import 'Adidasmenaceesories.dart';
import 'Adidasmenclothing.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  // Tabs
  final List<String> tabs = ["MEN", "WOMEN", "KIDS"];

  // 🔥 Banner images for each tab
  final Map<String, String> bannerImages = {
    "MEN": "assets/adidasshirt.jpg",
    "WOMEN": "assets/Adidaswomen.jpg",
    "KIDS": "assets/Adidaskids.jpg",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "SHOP",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: false,
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black, size: 28),
          SizedBox(width: 15),
          Icon(Icons.person_outline, color: Colors.black, size: 28),
          SizedBox(width: 10),
        ],
      ),

      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Find products...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
          ),

          // 🔄 Tabs for Men / Women / Kids
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                tabs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontWeight: _selectedIndex == index
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: _selectedIndex == index
                            ? Colors.black
                            : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Divider(height: 1, thickness: 0.5),

          // 📄 Animated PageView for MEN/WOMEN/KIDS
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                _buildCategoryPage("MEN"),
                _buildCategoryPage("WOMEN"),
                _buildCategoryPage("KIDS"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Each Page Content
  Widget _buildCategoryPage(String section) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 🖼️ Banner Section
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                bannerImages[section] ?? "assets/adidasshirt.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔗 Categories
          _buildCategory(
            Icons.directions_run,
            "$section SHOES",
            onTap: () {
              if (section == "MEN") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menshoes()),
                );
              } else if (section == "WOMEN") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Womenshoes()),
                );
              } else if (section == "KIDS") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Kidsshoes()),
                );
              }
            },
          ),
          _buildCategory(
            Icons.checkroom_outlined,
            "$section CLOTHING",
            onTap: () {
              if (section == "MEN") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menclothing()),
                );
              } else if (section == "WOMEN") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Adidaswomenclothing(),
                  ),
                );
              } else if (section == "KIDS") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Kidsclothing()),
                );
              }
            },
          ),
          _buildCategory(
            Icons.watch_outlined,
            "$section ACCESSORIES",
            onTap: () {
              if (section == "MEN") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menacessories()),
                );
              } else if (section == "WOMEN") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menacessories()),
                );
              } else if (section == "KIDS") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menacessories()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Reusable category tile with navigation support
  Widget _buildCategory(IconData icon, String title, {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black, size: 28),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.black),
          onTap: onTap,
        ),
        const Divider(height: 1, thickness: 0.5),
      ],
    );
  }
}
