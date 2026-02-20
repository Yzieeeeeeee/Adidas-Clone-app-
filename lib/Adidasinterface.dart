import 'package:firebase/Adidasinterest.dart';
import 'package:firebase/highlightdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Detailedproductpage.dart';
import 'User.dart';

class AdidasInterface extends StatefulWidget {
  const AdidasInterface({super.key});

  @override
  State<AdidasInterface> createState() => _AdidasInterfaceState();
}

class _AdidasInterfaceState extends State<AdidasInterface> {
  int _currentIndex = 0;

  /// 🔹 Highlight Widget
  Widget highlight(String img, String itemname) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HighlightDetailPage(
              name: itemname,
              image: img,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: img,
            child: Container(
              width: double.infinity,
              height: 600,
              decoration: const BoxDecoration(color: Colors.black),
              child: Image.network(img, fit: BoxFit.cover),
            ),
          ),
          const Positioned(
            top: 10,
            left: 10,
            child: Text(
              'HIGHLIGHT',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 65,
            left: 50,
            child: Container(
              width: 115,
              height: 30,
              color: Colors.white,
              child: const Center(
                child: Text(
                  'JUST DROPPED',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 50,
            child: Container(
              width: 300,
              height: 50,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SHOP NOW',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Product Card Widget
  Widget buildProductCard(String docId, Map<String, dynamic> data) {
    List<dynamic> images = [];
    if (data['Image'] is List) {
      images = data['Image'];
    } else if (data['Image'] is String) {
      images = [data['Image']];
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(docId: docId, a:data),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: images.isNotEmpty
                  ? Image.network(
                images[0],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, size: 40),
                ),
              )
                  : Container(
                height: 200,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported, size: 40),
              ),
            ),
            /// Price & Name
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹${data['Price']?.toString() ?? '0'}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['Name'] ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Product Grid
  Widget adidasProductGrid() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Adidasproducts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text("Error loading products"));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        var products = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: products.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: buildProductCard(doc.id, data),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('HELLO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.profile_circled, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UsersPage()));
            },
          ),
          const SizedBox(width: 15),
          const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔹 Main Banners
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Adidasinterfacemainbanner').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Center(child: Text("Error loading banners"));
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                var banners = snapshot.data!.docs;

                return Column(
                  children: banners.map((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    return Container(
                      width: double.infinity,
                      height: 400,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data['Image'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 70,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                data['Title'] ?? 'JUST FOR YOU',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: 150,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
                              ),
                              child: const Center(
                                child: Text(
                                  'SHOP NOW',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 20),

            /// 🔹 Products
            adidasProductGrid(),

            const SizedBox(height: 20),

            /// 🔹 Highlights
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Adidashighlights').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Center(child: Text("Error loading highlights"));
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                var highlights = snapshot.data!.docs;

                return Column(
                  children: [
                    CarouselSlider(
                      items: highlights.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        return highlight(data['Image'] ?? '', data['Name'] ?? '');
                      }).toList(),
                      options: CarouselOptions(
                        height: 600,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() => _currentIndex = index);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: highlights.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key ? Colors.black : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),

            /// 🔹 Footer & Interests (unchanged)
            // ... you can keep your existing footer/interests UI here
          ],
        ),
      ),
    );
  }
}
