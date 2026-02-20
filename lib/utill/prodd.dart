import 'package:flutter/material.dart';

class Pro extends StatefulWidget {
  final List images;
  final String name;
  final String price;
  final Function(int)? onImageChange;

  const Pro({
    super.key,
    required this.images,
    required this.name,
    required this.price,
    this.onImageChange,
  });

  @override
  State<Pro> createState() => _ProState();
}

class _ProState extends State<Pro> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); // Floating animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 🌀 Floating shoe animation
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double offset = 15 * (1 - (2 * _controller.value - 1).abs());
            return Transform.translate(
              offset: Offset(0, -offset),
              child: child,
            );
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            switchInCurve: Curves.easeInOutBack,
            switchOutCurve: Curves.easeInOutBack,
            transitionBuilder: (child, animation) {
              // ✨ Smooth fade + scale + slide transition
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
              );
            },
            child: widget.images.isNotEmpty
                ? Image.network(
                    widget.images[selectedIndex],
                    key: ValueKey(widget.images[selectedIndex]),
                    width: MediaQuery.of(context).size.width * 0.75,
                    fit: BoxFit.contain,
                  )
                : const Icon(Icons.image, size: 150, color: Colors.white30),
          ),
        ),

        // 🎨 Right-side color selector dots
        Positioned(
          right: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.images.length, (idx) {
              bool isSelected = selectedIndex == idx;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = idx;
                  });
                  if (widget.onImageChange != null){
                    widget.onImageChange !(idx);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: isSelected ? 24 : 18,
                  height: isSelected ? 24 : 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.amber : Colors.white70,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.images[idx]),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.6),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                ),
              );
            }),
          ),
        ),

      ],
    );
  }
}
