import 'package:flutter/material.dart';
import 'package:flutter_workshops_5sae1_2627/CartPage.dart';
import 'package:flutter_workshops_5sae1_2627/GStore.dart';

class HouseOfDeadDetail extends StatelessWidget {
  const HouseOfDeadDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("House Of Dead"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/HouseOfDead.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "The House of the Dead and its 2022 remake take place in 1998, following AMS agents Thomas Rogan and G as they raid the mansion of Dr. Curien, a genetic engineer who went insane and has released creatures upon his own research team.",
              style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 32),
            const Text(
              "300 DT",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                final item = {'title': 'House Of Dead', 'image': 'assets/images/HouseOfDead.jpg'};
                if (!cartItems.any((e) => e['title'] == item['title'])) {
                  cartItems.add(item);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartPage()),
                );
              },
              icon: const Icon(Icons.shopping_basket),
              label: const Text(
                "Acheter",
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
