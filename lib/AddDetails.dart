import 'package:flutter/material.dart';
import 'package:studentprj/MySubject.dart';
import 'package:studentprj/subject.dart';
import 'package:studentprj/subjectData.dart';
class AddSubject extends StatefulWidget {
 const AddSubject({super.key});

 @override
 State<AddSubject> createState() => _AddSubject();
}

class _AddSubject extends State<AddSubject> {
 final _formKey = GlobalKey<FormState>();
final TextEditingController nameController = TextEditingController();
final TextEditingController codeController = TextEditingController();

void saveSubject(){
  if(_formKey.currentState!.validate()){

    Subject newsubject = Subject(name: nameController.text.trim(), code: codeController.text.trim() , image: mySubLists[0].image, video: mySubLists[0].video);
    mySubLists.add(newsubject);
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Mysubject()));
     ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('New Subject Add Successfully'),
                  behavior: SnackBarBehavior.floating,
                   duration: const Duration(seconds: 1)
                  ));
                
  }

}

@override
 Widget build(BuildContext context) {
  return Scaffold(
   backgroundColor: Color(0xFFF4F7FC),

   appBar: AppBar(
    title: Text('Add New Subject'),
    backgroundColor: Color(0xFF246BFD),
    foregroundColor: Colors.white,
   ),

   body: SingleChildScrollView(
    padding: EdgeInsets.all(10),

    child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
      Container(
       width: double.infinity,
       height: 200,
       padding: EdgeInsets.all(25),
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
         image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-e_TZTPn3BhFQB5KaPAjEX1Z92fmMUFE3IBdLDAvggXGu44rlEiIHQ5Q&s=10'),
         fit: BoxFit.cover,
        ),
       ),
       child: Column(
        children: [
         Icon(
          Icons.menu_book_rounded,
          size: 65,
          color: Colors.white,
         ),
         SizedBox(height: 12),
         Text(
          'Create New Subject',
          style: TextStyle(
           fontSize: 22,
           fontWeight: FontWeight.bold,
           color: Colors.white,
          ),
         ),
         SizedBox(height: 5),
         Text(
          'Enter your subject information below',
          style: TextStyle(color: Colors.white70),
         ),
        ],
       ),
      ),

      SizedBox(height: 30),

      Text(
       'Subject Information',
       style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
       ),
      ),

      SizedBox(height: 20),

      Form(
       key: _formKey,
       child: Column(
        children: [
         TextFormField(
         controller: nameController,
          decoration: InputDecoration(
           labelText: 'Subject Name',
           hintText: 'Enter subject name',
           filled: true,
           fillColor: Colors.white,
           border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
           ),
          ),
          validator: (value) {
           if (value == null || value.trim().isEmpty) {
            return 'Subject Name is required';
           }
           return null;
          },
         ),

         SizedBox(height: 20),

         TextFormField(
          controller: codeController,
          decoration: InputDecoration(
           labelText: 'Subject Code',
           hintText: 'Enter subject code',
           filled: true,
           fillColor: Colors.white,
           border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
           ),
          ),
          validator: (value) {
           if (value == null || value.trim().isEmpty) {
            return 'Subject Code is required';
           }
           return null;
          },
         ),

         SizedBox(height: 35),

         SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
           onPressed: () {
            saveSubject();
           },
           icon: Icon(Icons.save),
           label: Text('Save Subject'),
           style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF246BFD),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(12),
            ),
           ),
          ),
         ),
        ],
       ),
      ),
     ],
    ),
   ),
  );
 }
}
