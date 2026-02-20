import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Carr extends StatefulWidget {
  const Carr({super.key});

  @override
  State<Carr> createState() => _CarrState();
}

class _CarrState extends State<Carr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users",style: TextStyle(fontWeight: FontWeight.bold),)),
      body: StreamBuilder<QuerySnapshot>(
        // 👇 Replace "products" with your collection name
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data found"));
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: data["Image"] != null
                      ? Image.network(
                    data["Image"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.image),
                  title: Text(data["Name"] ?? "No Title"),
                  subtitle: Text(data["Age"].toString()),
                  trailing: Text(data['Gender'] ?? "--"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
