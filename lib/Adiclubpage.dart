import 'package:flutter/material.dart';
import 'AdiclubPopup.dart';

class AdiclubPage extends StatelessWidget {
  const AdiclubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("adiClub"),
          ),
          backgroundColor: Colors.white,

          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code_2),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AdiclubPopup(
                    name: "M",
                    level: 1,
                    qrCode: "ADIUS62908692732",
                  ),
                );
              },
            ),
          ],
        ),
        body: const Center(
          child: Text(
            "Welcome to adiClub",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
