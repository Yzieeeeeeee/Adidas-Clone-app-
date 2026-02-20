import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Kidsclothing extends StatefulWidget {
  const Kidsclothing({super.key});

  @override
  State<Kidsclothing> createState() => _KidsclothingState();
}

class _KidsclothingState extends State<Kidsclothing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kids Clothing",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Adidaskidsclothing") // 👈 Firestore collection name
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No clothing available",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          final clothes = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // two items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: clothes.length,
            itemBuilder: (context, index) {
              var data = clothes[index].data() as Map<String, dynamic>;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: data["Image"] != null
                            ? Image.network(
                          data["Image"],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                            : Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image, size: 40),
                        ),
                      ),
                    ),

                    // Product Name & Price
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data["Name"] ?? "Clothing Item",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "₹${data["Price"] ?? "0"}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
