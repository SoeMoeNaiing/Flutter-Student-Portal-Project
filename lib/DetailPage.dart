import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'subject.dart';
class Subjectdetailscreen extends StatefulWidget {
  final Subject subject;

  const Subjectdetailscreen({
    super.key,
    required this.subject,

  });
  

  @override
  State<Subjectdetailscreen> createState() => _Subjectdetailscreen();
  
}

class _Subjectdetailscreen extends State<Subjectdetailscreen> {
 late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(
      widget.subject.video,
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
 
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
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          children: [

            // Header
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.only(top:5),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(widget.subject.image),opacity: 0.8,fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  /*Icon(
                    Icons.menu_book_rounded,
                    size: 50,
                    color: Colors.white,
                  ),*/

                  SizedBox(height: 15),

                  Text(
                    widget.subject.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Your Learning Journey Starts Here',
                    style: TextStyle(
                     
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
                                widget.subject.name,
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
                                widget.subject.code,
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
            
            Text(
              'Lecture Video',
               style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
                  ),
                ),
            
              SizedBox(height: 20),
              // Video Player
              Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: controller.value.isInitialized
            ? Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(controller),

                // Play / Pause Button
                IconButton(
                  iconSize: 55,
                  color: Colors.white,
                  icon: Icon(
                    controller.value.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                  ),
                  onPressed: () {
                    setState(() {
                      if (controller.value.isPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    });
                  },
                ),

                // Progress Bar at Bottom
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: VideoProgressIndicator(
                    controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Colors.white,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.white30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      : Center(
          child: CircularProgressIndicator(),
        ),
),
          
            SizedBox(height: 25),

            // Action Button
            Padding(
  padding: EdgeInsets.only(
    left: 20,
    right: 20,
    bottom: 30,
  ),
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
          ],
        ),
      ),
    );
  }
}
  