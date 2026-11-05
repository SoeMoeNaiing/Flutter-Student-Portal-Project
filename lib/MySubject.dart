import 'package:flutter/material.dart';
import 'subjectData.dart';
import 'AddDetails.dart';
import 'DetailPage.dart';
class Mysubject extends StatefulWidget {
 const Mysubject({super.key});

 @override
 State<Mysubject> createState() => _MysubjectState();
}

class _MysubjectState extends State<Mysubject> {
 @override
 Widget build(BuildContext context) {
  return Scaffold(
   backgroundColor: Color(0xFFF4F7FC),

   appBar: AppBar(
    title: Text(
     'My Subjects',
     style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
     ),
    ),
    backgroundColor: Color(0xFF246BFD),
    foregroundColor: Colors.white,
    elevation: 0,
   ),

   body: Column(
    children: [

     // Header
     Container(
      width: double.infinity,
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
       //color: Color(0xFF246BFD),
       borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
       ),
       image: DecorationImage(
         image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLZew4ph-gJDXJAEBJpIODRZjX6HMP_3rFzEPuLbgDbZAp0DikT-HXQKK2&s=10'),
         fit: BoxFit.cover,
        ),
      ),

      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

        Text(
         'Welcome Back!',
         style: TextStyle(
          color: Colors.white70,
          fontSize: 15,
         ),
        ),

        SizedBox(height: 5),

        Text(
         'Manage Your Learning',
         style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
         ),
        ),

        SizedBox(height: 20),

        // Total Subjects
        Container(
         padding: EdgeInsets.all(18),
         decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 237, 237).withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
         ),

         child: Row(
          children: [
           Icon(
            Icons.menu_book_rounded,
            size: 40,
            color: Colors.white,
           ),

           SizedBox(width: 15),

           Column(
            crossAxisAlignment:
              CrossAxisAlignment.start,
            children: [
             Text(
              'Total Subjects',
              style: TextStyle(
               color: Colors.black,
              ),
             ),

             Text(
              '${mySubLists.length}',
              style: TextStyle(
               color: Colors.black,
               fontSize: 25,
               fontWeight: FontWeight.bold,
              ),
             ),
            ],
           ),
          ],
         ),
        ),
       ],
      ),
     ),

     

     // Subject List
     Expanded(
      child: ListView.builder(
          padding: EdgeInsets.symmetric(
           horizontal: 16,
           vertical: 5,
          ),
          itemCount: mySubLists.length,

          itemBuilder: (context, index) {
           final subject = mySubLists[index];

           return Card(
            elevation: 2,
            shadowColor: Colors.black12,
            margin: EdgeInsets.only(bottom: 13),
            color: Colors.white,
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(16),
            ),

            child: ListTile(
             contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
             ),

             leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
               color: Color(0xFFE8F0FF),
               borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
               Icons.menu_book_rounded,
               color: Color(0xFF246BFD),
               size: 27,
              ),
             ),

             title: Text(
              subject.name,
              style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 15,
              ),
             ),

             subtitle: Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
               subject.code,
               style: TextStyle(
                color: Colors.grey[600],
               ),
              ),
             ),

             trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
             ),

             onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SubjectDetailScreen(subject: subject)));
              // ScaffoldMessenger.of(context)
              //   .showSnackBar(
              //  SnackBar(
              //   content: Text(
              //    'Selected: ${subject.name}',
              //   ),
              //  ),
              // ); 
             },
            ),
           );
          },
         ),
     ),
    ],
   ),
   floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSubject()));
    },
    // mini: true,
    child: Icon(Icons.add),
    tooltip: 'Add Subject',
   ),
  );
 }
}

