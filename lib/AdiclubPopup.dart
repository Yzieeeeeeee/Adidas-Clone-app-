import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AdiclubPopup extends StatelessWidget {
  final String name;
  final int level;
  final String qrCode;

  const AdiclubPopup({
    super.key,
    required this.name,
    required this.level,
    required this.qrCode,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "adiclub",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "$name.",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "LEVEL $level",
                        style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      QrImageView(
                        data: qrCode,
                        size: 140,
                        embeddedImage: const AssetImage('assets/adidas.png'),
                        embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(30, 30)),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        qrCode,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
