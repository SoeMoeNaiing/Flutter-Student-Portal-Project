import 'package:flutter/material.dart'; 
class StudentProfile extends StatelessWidget {
 const StudentProfile({super.key});

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   backgroundColor: Colors.grey[100],
   appBar: AppBar(title:Text('Student Profile')),
   body: SingleChildScrollView( //scrollable when content exceeds screen height
    child: Padding(
     padding: const EdgeInsets.all(20),

     child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,//horizontal alignment of the column
      children: [

       // Profile Container
       Container(
        width: double.infinity, //take full width of the parent(container)
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
         children: [
          
          CircleAvatar( //circular profile picture
           radius: 50,
           backgroundImage: NetworkImage('https://img.magnific.com/free-photo/portrait-smiling-young-man_1268-21877.jpg?semt=ais_hybrid&w=740&q=80'),
           //backgroundImage:NetworkImage('https://example.com/profile.jpg')
           //backgroundColor: Colors.blue,
           /*child: Icon(
            Icons.person,
            size: 60,
            color: Colors.white,
           ),*/
          ),

          const SizedBox(height: 15),

          const Text(
           'Aung Aung',
           style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
           ),
          ),

          const SizedBox(height: 5),

          const Text(
           '+959967025640',
           style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
           ),
          ),

          const SizedBox(height: 20),

          // Information Row
          Row(
           children: [

            Expanded(//fill avaliable space in main axis of the row
             child: Column(
              children: const [
               Icon(Icons.school,
                 color: Colors.blue),
               SizedBox(height: 5),
               Text('Second Year'),
              ],
             ),
            ),

            Expanded(
             child: Column(
              children: const [
               
              
               Icon(Icons.location_on,
                 color: Colors.blue),
               SizedBox(height: 5),
               Text('University of Computer Studies, Taungoo'),
              ],
             ),
            ),

            Expanded(
             child: Column(
              children: const [
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Icon(Icons.star,
                   color: Colors.orange),
                   Icon(Icons.star,
                 color: Colors.orange),
                ],
               ),
                
               SizedBox(height: 5),
               Text('Excellent Student'),
              ],
             ),
            ),
           ],
          ),
         ],
        ),
       ),

       const SizedBox(height: 20),

       // Personal Information
       Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

          const Text(
           'Personal Information',
           style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
           ),
          ),

          const SizedBox(height: 20),

          // Name Row
          Row(
           children: const [
            Icon(Icons.person, color: Colors.blue),
            SizedBox(width: 15),
            Expanded(
             child: Text('Name: Aung Aung'),
            ),
           ],
          ),

          const SizedBox(height: 15),

          // Age Row
          Row(
           children: const [
            Icon(Icons.cake, color: Colors.blue),
            SizedBox(width: 15),
            Expanded(
             child: Text('Age: 20 Years'),
            ),
           ],
          ),

          const SizedBox(height: 15),

          // Email Row
          Row(
           children: const [
            Icon(Icons.email, color: Colors.blue),
            SizedBox(width: 15),
            Expanded(
             child: Text(
              'Email: aungaung@gmail.com',
             ),
            ),
           ],
          ),

          const SizedBox(height: 15),

          // Address Row
          Row(
           children: const [
            Icon(Icons.home, color: Colors.blue),
            SizedBox(width: 15),
            Expanded(
             child: Text('Address: Taungoo'),
            ),
           ],
          ),
         ],
        ),
       ),
      ],
     ),
    ),
   ),
  );
 }
}
