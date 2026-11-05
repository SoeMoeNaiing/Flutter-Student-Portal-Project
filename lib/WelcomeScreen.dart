import 'package:flutter/material.dart';
import 'package:studentprj/MySubject.dart';
import 'package:studentprj/ProfileScreen.dart';
class WelcomeScreen extends StatefulWidget {
 const WelcomeScreen({super.key});

 @override
 State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
 final Color primaryBlue = const Color(0xFF246BFD);
 final Color backgroundColor = const Color(0xFFF4F7FC);

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   backgroundColor: backgroundColor,

   body: SafeArea(
    child: SingleChildScrollView(
     child: Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

        // Top Header
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
          Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Text(
             'HELLO, STUDENT 👋',
             style: TextStyle(
              color: primaryBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
             ),
            ),

            const SizedBox(height: 8),

            const Text(
             'Welcome Home!',
             style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
             ),
            ),
           ],
          ),

          CircleAvatar(
           radius: 27,
           backgroundColor: Colors.white,
           child: Icon(
            Icons.school_rounded,
            color: primaryBlue,
            size: 30,
           ),
          ),
         ],
        ),

        const SizedBox(height: 25),

        // Welcome Banner
        Container(
         width: double.infinity,
         height: 190,
         padding: const EdgeInsets.all(22),

         decoration: BoxDecoration(
          color: primaryBlue,
          borderRadius: BorderRadius.circular(25),
          image: const DecorationImage(
           image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK4_5y9c4lWUgPJHqW0ni9CpUjL9NQVvfeGlzAlv4mi_X2mNFlbuDhyXDe&s=10'),
           fit: BoxFit.cover,
           opacity: 0.5,
          ),
         ),

         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
           Text(
            'Learning Made Easy!',
            style: TextStyle(
             fontSize: 23,
             fontWeight: FontWeight.bold,
             color: Colors.white,
            ),
           ),

           SizedBox(height: 10),

           Text(
            'Explore your subjects and\nmanage your student profile.',
            style: TextStyle(
             color: Colors.white,
             fontSize: 15,
             height: 1.5,
            ),
           ),
          ],
         ),
        ),

        const SizedBox(height: 30),

        // Section Title
        const Text(
         'Explore',
         style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
         ),
        ),

        const SizedBox(height: 15),

        // My Subjects Card
        menuCard(
         title: 'My Subjects',
         subtitle: 'View all your learning subjects',
         icon: Icons.menu_book_rounded,
         color: const Color(0xFF246BFD),
         onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Mysubject()));
          
         },
        ),

        const SizedBox(height: 15),

        // Student Profile Card
        menuCard(
         title: 'Student Profile',
         subtitle: 'View your personal information',
         icon: Icons.person_rounded,
         color: const Color(0xFFFF9F43),
         onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentProfile()));
         },
        ),

        const SizedBox(height: 30),

        // Footer
        Center(
         child: Text(
          'Learn Something New Every Day ✨',
          style: TextStyle(
           color: Colors.grey.shade600,
           fontSize: 13,
          ),
         ),
        ),
       ],
      ),
     ),
    ),
   ),
  );
 }

 // Reusable Menu Card
 Widget menuCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
 }) {
  return InkWell(
   onTap: onTap,
   borderRadius: BorderRadius.circular(20),

   child: Container(
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
     color: Colors.white,
     borderRadius: BorderRadius.circular(20),
     boxShadow: [
      BoxShadow(
       color: Colors.black.withOpacity(0.05),
       blurRadius: 12,
       offset: const Offset(0, 5),
      ),
     ],
    ),

    child: Row(
     children: [
      Container(
       width: 58,
       height: 58,

       decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
       ),

       child: Icon(
        icon,
        color: color,
        size: 30,
       ),
      ),

      const SizedBox(width: 15),

      Expanded(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text(
          title,
          style: const TextStyle(
           fontSize: 17,
           fontWeight: FontWeight.bold,
          ),
         ),

         const SizedBox(height: 6),

         Text(
          subtitle,
          style: TextStyle(
           fontSize: 12,
           color: Colors.grey.shade600,
          ),
         ),
        ],
       ),
      ),

      Icon(
       Icons.arrow_forward_ios_rounded,
       size: 18,
       color: Colors.grey.shade400,
      ),
     ],
    ),
   ),
  );
 }
}