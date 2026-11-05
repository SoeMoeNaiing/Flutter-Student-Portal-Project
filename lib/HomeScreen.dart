import 'package:flutter/material.dart';
import 'package:studentprj/MySubject.dart';
import 'package:studentprj/TodoScreen.dart';
import 'package:studentprj/WelcomeScreen.dart';
import 'ProfileScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _Homescreen();
}

class _Homescreen extends State<Homescreen> {
  int selectedIndex = 0;

  // ✅ 4 tabs — matches 4 nav items exactly, no missing entries
  // (no `const` on the list in case Mysubject() isn't const-constructible)
  final List<Widget> pages = [
    const WelcomeScreen(),
    Mysubject(),
    const StudentProfile(),
    const TodoScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Fail loudly during development if the tab count ever drifts again
    assert(
      pages.length == 4,
      'pages.length (${pages.length}) must match bottom nav item count (4)',
    );
  }

  @override
  Widget build(BuildContext context) {
    // AppBar belongs to Homescreen only on tab 0 (Welcome has none).
    // Tabs 1–3 have their own AppBars inside their own Scaffolds.
    final bool showHomeAppBar = selectedIndex == 0;

    return Scaffold(
      appBar: showHomeAppBar
          ? AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Student Portal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Welcome to your learning space',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                onPressed: () {
                  print('Menu pressed');
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No new notifications')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined,
                      color: Colors.white),
                  onPressed: () {
                    print('Settings pressed');
                  },
                ),
                const SizedBox(width: 8),
              ],
              backgroundColor: const Color(0xFF246BFD),
              foregroundColor: Colors.white,
              toolbarHeight: 75,
              elevation: 4,
              shadowColor: Colors.black26,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
            )
          : null,

      // IndexedStack keeps every tab's state alive when switching
      body: IndexedStack(
        index: selectedIndex.clamp(0, pages.length - 1), // extra safety
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF246BFD),
        unselectedItemColor: Colors.grey.shade500,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: 'MySubjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl_rounded),
            label: 'To-Do',
          ),
        ],
      ),

      // FAB only on Home
      floatingActionButton: showHomeAppBar
          ? FloatingActionButton(
              onPressed: () {},
              mini: true,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}