import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utill/prodd.dart';

class ProductDetailPage extends StatefulWidget {
  final String docId;
  final Map a;

  const ProductDetailPage({
    super.key,
    required this.docId,
    required this.a,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String bgImage = 'assets/neonbg.jpg';
  Color textColor = Colors.white;
  Color priceColor = Colors.amber;
  Color buttonColor = Colors.white12;
  Color buttonTextColor = Colors.white;

  @override
  void initState() {
    super.initState();
    bgImage = 'assets/neonbg.jpg';
  }

  void onShoechange(int index) {
    setState(() {
      if (index == 0) {
        bgImage = 'assets/background2.jpg';
        textColor = Colors.black;
        priceColor = Colors.amber;
        buttonColor = Colors.white12;
        buttonTextColor = Colors.white;
      } else if (index == 1) {
        bgImage = 'assets/neonbg.jpg';
        textColor = Colors.white;
        priceColor = Colors.redAccent;
        buttonColor = Colors.black26;
        buttonTextColor = Colors.white12;
      } else if (index == 2) {
        bgImage = 'assets/bluebackground.jpg';
        textColor = Colors.yellow;
        priceColor = Colors.greenAccent;
        buttonColor = Colors.yellow.withOpacity(0.3);
        buttonTextColor = Colors.white;
      } else if (index == 3) {
        bgImage = 'assets/brownbackground.jpg';
        textColor = Colors.white;
        priceColor = Colors.amber;
        buttonColor = Colors.white12;
        buttonTextColor = Colors.white;
      }
    });
  }

  // 🔹 Fetch related products using IDs
  Future<List<Map<String, dynamic>>> fetchRelatedProducts(
      List<String> ids) async {
    if (ids.isEmpty) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where(FieldPath.documentId, whereIn: ids)
        .get();

    return snapshot.docs
        .map((doc) => {
      ...doc.data(),
      'id': doc.id,
    })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: Image.asset(
                key: ValueKey(bgImage),
                bgImage,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),

                    Text(
                      'THE PURE COMFORT IS HERE.',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // 🔹 Main Product Widget
                    Pro(
                      images: (widget.a['Image'] is List)
                          ? widget.a['Image']
                          : (widget.a['Image'] is String)
                          ? [widget.a['Image']]
                          : [],
                      name: widget.a['Name']?.toString() ?? 'No Name',
                      price: widget.a['Price']?.toString() ?? '0',
                      onImageChange: onShoechange,
                    ),

                    const SizedBox(height: 20),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "Disrupt",
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        Text(
                          widget.a['Name'] ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "₹${widget.a['Price']?.toString() ?? '0'}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: priceColor,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "RESERVE NOW",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonTextColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "LEARN MORE",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // ================= RELATED PRODUCTS =================

                    if (widget.a['relatedProducts'] != null &&
                        widget.a['relatedProducts'] is List)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Related Products",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 14),

                            SizedBox(
                              height: 160,
                              child: FutureBuilder<
                                  List<Map<String, dynamic>>>(
                                future: fetchRelatedProducts(
                                  List<String>.from(
                                      widget.a['relatedProducts']),
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  final products = snapshot.data!;

                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: products.length,
                                    separatorBuilder: (_, __) =>
                                    const SizedBox(width: 12),
                                    itemBuilder: (context, index) {
                                      final item = products[index];
                                      final image =
                                      (item['Image'] is List &&
                                          item['Image'].isNotEmpty)
                                          ? item['Image'][0]
                                          : null;

                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProductDetailPage(
                                                    docId: item['id'],
                                                    a: item,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12),
                                                  child: image != null
                                                      ? Image.network(
                                                    image,
                                                    fit: BoxFit.cover,
                                                    width:
                                                    double.infinity,
                                                  )
                                                      : Container(
                                                    color:
                                                    Colors.black26,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8),
                                                child: Text(
                                                  item['Name'] ?? '',
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
