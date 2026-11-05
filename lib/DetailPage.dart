// ignore: file_names
import 'package:flutter/material.dart';
import 'package:studentprj/MySubject.dart';
import 'subject.dart';
import 'MySubject.dart';

class SubjectDetailScreen extends StatelessWidget {
 final Subject subject;

 const SubjectDetailScreen({
  super.key,
  required this.subject,
 });

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   backgroundColor: Color(0xFFF4F7FC),

   appBar: AppBar(
    title: Text('Subject Details'),
    backgroundColor: Color(0xFF246BFD),
    foregroundColor: Colors.white,
    elevation: 0,
   ),

   body: SingleChildScrollView(
    child: Column(
     children: [

      // Header
      Container(
       width: double.infinity,
       margin: EdgeInsets.only(top:20),
       padding: EdgeInsets.all(25),
       decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyJcZrUrKTk_mF3327iUIyf2wdIR_HfMgagV7y8dC2EKVEB3lb8PwwHHU&s=10'),opacity: 0.8),
        borderRadius: BorderRadius.only(
         bottomLeft: Radius.circular(30),
         bottomRight: Radius.circular(30),
        ),
       ),

       child: Column(
        children: [
         Icon(
          Icons.menu_book_rounded,
          size: 85,
          color: Colors.white,
         ),

         SizedBox(height: 15),

         Text(
          subject.name,
          textAlign: TextAlign.center,
          style: TextStyle(
           fontSize: 25,
           fontWeight: FontWeight.bold,
           color: Colors.white,
          ),
         ),

         SizedBox(height: 8),

         Text(
          'Your Learning Journey Starts Here',
          style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold,
           fontSize: 20,
          ),
         ),
        ],
       ),
      ),

      SizedBox(height: 25),

      // Subject Information
      Padding(
       padding: EdgeInsets.symmetric(horizontal: 20),

       child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
         padding: EdgeInsets.all(20),

         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           Text(
            'Subject Information',
            style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
            ),
           ),

           SizedBox(height: 20),

           Row(
            children: [
             Icon(
              Icons.bookmark,
              color: Color(0xFF246BFD),
             ),
             SizedBox(width: 12),
             Column(
              crossAxisAlignment:
                CrossAxisAlignment.start,
              children: [
               Text(
                'Subject Name',
                style: TextStyle(
                 color: Colors.grey,
                ),
               ),
               Text(
                subject.name,
                style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
                ),
               ),
              ],
             ),
            ],
           ),

           Divider(height: 30),

           Row(
            children: [
             Icon(
              Icons.qr_code,
              color: Color(0xFF246BFD),
             ),
             SizedBox(width: 12),
             Column(
              crossAxisAlignment:
                CrossAxisAlignment.start,
              children: [
               Text(
                'Subject Code',
                style: TextStyle(
                 color: Colors.grey,
                ),
               ),
               Text(
                subject.code,
                style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
                ),
               ),
              ],
             ),
            ],
           ),
          ],
         ),
        ),
       ),
      ),

      SizedBox(height: 25),

      // Action Button
      Padding(
       padding: EdgeInsets.symmetric(horizontal: 20),

       child: SizedBox(
        width: double.infinity,
        height: 55,

        child: ElevatedButton.icon(
         onPressed: () {
          Navigator.pop(context);
         },

         icon: Icon(Icons.arrow_back),
         label: Text(
          'Back to My Subjects',
          style: TextStyle(fontSize: 16),
         ),

         style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF246BFD),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(15),
          ),
         ),
        ),
       ),
      ),

      SizedBox(height: 25),
     ],
    ),
   ),
  );
 }
}
