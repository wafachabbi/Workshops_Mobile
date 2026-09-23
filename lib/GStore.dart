import 'package:flutter/material.dart';
import 'package:flutter_workshops_5sae1_2627/CartPage.dart';
import 'package:flutter_workshops_5sae1_2627/HouseOfDeadDetail.dart';

// Simple cart state shared between pages
List<Map<String, String>> cartItems = [
  {'title': 'House Of Dead', 'image': 'assets/images/HouseOfDead.jpg'},
  {'title': 'The Abyss', 'image': 'assets/images/thegrudge.jpg'},
  {'title': 'Ice Road', 'image': 'assets/images/iceroad.jpg'},
];

class Gstore extends StatefulWidget {
  const Gstore({super.key});

  @override
  State<Gstore> createState() => _GstoreState();
}

class _GstoreState extends State<Gstore> {
  final List<Map<String, String>> movies = [
    {'title': 'House Of Dead', 'image': 'assets/images/HouseOfDead.jpg', 'badge': ''},
    {'title': 'The Abyss', 'image': 'assets/images/thegrudge.jpg', 'badge': 'NEW'},
    {'title': 'Ice Road', 'image': 'assets/images/iceroad.jpg', 'badge': ''},
    {'title': 'The Grudge', 'image': 'assets/images/thegrudge.jpg', 'badge': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("G-STORE", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              if (movie['title'] == 'House Of Dead') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HouseOfDeadDetail()),
                );
              }
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                          child: Image.asset(
                            movie['image']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (movie['badge']!.isNotEmpty)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: _BadgeBanner(label: movie['badge']!),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Text(
                      movie['title']!,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BadgeBanner extends StatelessWidget {
  final String label;
  const _BadgeBanner({required this.label});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Banner(
        message: label,
        location: BannerLocation.topEnd,
        color: Colors.red,
        textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
