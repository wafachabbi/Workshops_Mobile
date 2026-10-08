import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'GStore.dart';
import 'HouseOfDeadDetail.dart';
import 'LibraryPage.dart';
import 'CartPage.dart';
import 'ProfileSettingsPage.dart';
import 'SignInPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Rebuild pages when switching tabs so cart updates reflect
  List<Widget> get _pages => [
    const StoreTab(),
    const LibraryPage(),
    const CartTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.black54,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Bibliothèque',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Basket',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.movie_filter, size: 40),
                  const SizedBox(width: 12),
                  Text(
                    currentUser?.username ?? 'User',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Update Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileSettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                currentUser = null;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInPage()),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chevron_right),
              title: const Text('Go to Nav Bar'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Store tab (wraps existing Gstore list with AppBar drawer toggle) ─────────

class StoreTab extends StatefulWidget {
  const StoreTab({super.key});

  @override
  State<StoreTab> createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {
  final List<Map<String, String>> movies = [
    {
      'title': 'House Of Dead',
      'image': 'assets/images/HouseOfDead.jpg',
      'badge': '',
    },
    {
      'title': 'The Abyss',
      'image': 'assets/images/thegrudge.jpg',
      'badge': 'NEW',
    },
    {
      'title': 'Ice Road',
      'image': 'assets/images/iceroad.jpg',
      'badge': '',
    },
    {
      'title': 'The Grudge',
      'image': 'assets/images/thegrudge.jpg',
      'badge': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STORE'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: Builder(
          builder:
              (ctx) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_basket_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              ).then((_) => setState(() {}));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Center(
              child: Text('Basket', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _MovieCard(movie: movie);
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Map<String, String> movie;
  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
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
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.asset(
                    movie['image']!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                if (movie['badge']!.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipRect(
                      child: Banner(
                        message: movie['badge']!,
                        location: BannerLocation.topEnd,
                        color: Colors.red,
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Cart tab (reuses CartPage directly) ──────────────────────────────────────

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CartPage();
  }
}
