import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:tiinver_project/models/feedTimeLineModel/feed_time_line_model.dart';

import '../../../constants/images_path.dart';
import '../../../providers/dashboard/dashboard_provider.dart';
import '../../../providers/signIn/sign_in_provider.dart';

class DetailScreen extends StatefulWidget {
  final Activity activity;

  const DetailScreen({
    super.key,
    required this.activity,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late VideoPlayerController _controller;
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    if (widget.activity.isVideo()) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.activity.objectUrl!))
        ..initialize().then((_) {
          setState(() {}); // When your video has been loaded
          _controller.play(); // Play the video when loaded
        });
    }
  }

  @override
  void dispose() {
    if (widget.activity.isVideo()) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.activity.id.toString());
    var signInP = Provider.of<SignInProvider>(context,listen: false);
    final commentProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
          surfaceTintColor: textColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,color: bgColor,)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 2.5.h,
                backgroundImage: NetworkImage(widget.activity.profile ?? ''),
              ),
              SizedBox(width: 20,),
              TextWidget1(
                  text: widget.activity.message!,
                  fontSize: 18.dp,
                  fontWeight: FontWeight.w700,
                  isTextCenter: false,
                  textColor: bgColor),
            ],
          ),
      ),
      body: Center(
        child: widget.activity.isImage()
            ? Image.network(widget.activity.objectUrl!, fit: BoxFit.cover)
            : widget.activity.isVideo() && _controller.value.isInitialized
            ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(
                _controller,
              ),
            )
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
        child: Row(
          children: [
            SizedBox(
                width: 8.w,
                child: Image.asset(
                  ImagesPath.likeIcon,
                  color: widget.activity.isLiked! ?
                  Colors.red : bgColor,)),
            SizedBox(width: 10,),
            TextWidget1(
                text: "${widget.activity.likes ?? ''}",
                fontSize: 20.dp, fontWeight: FontWeight.w700,
                isTextCenter: false, textColor: bgColor),
            SizedBox(width: 10,),
            InkWell(
              onTap: () {
                Get.bottomSheet(
                    Container(
                  height: 50.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 1.5.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 45.h,
                          child:FutureBuilder(
                            future: commentProvider.fetchComments(widget.activity.id!, signInP.userApiKey!), // Provide the actual userApiKey
                            builder: (context, snapshot) {
                              if (commentProvider.loading) {
                                return Center(child: CircularProgressIndicator());
                              }

                              if (commentProvider.error != null) {
                                return Center(child: Text('Error: ${commentProvider.error}'));
                              }

                              if (commentProvider.comments.isEmpty) {
                                return Center(child: Text('No comments found.'));
                              }

                              return ListView.builder(
                                itemCount: commentProvider.comments.length,
                                itemBuilder: (context, index) {
                                  final comment = commentProvider.comments[index];
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                      CircleAvatar(
                                        radius: 2.5.h,
                                      backgroundImage: NetworkImage(comment.profile!),
                                    ),
                                        SizedBox(width: 20,),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: lightGreyColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            )
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextWidget1(
                                                  text: "${comment.firstname} ${comment.lastname}",
                                                  fontSize: 10.dp,
                                                  fontWeight: FontWeight.w400,
                                                  isTextCenter: false,
                                                  textColor: themeColor
                                              ),
                                              TextWidget1(
                                                  text: comment.commentText!,
                                                  fontSize: 10.dp,
                                                  fontWeight: FontWeight.w400,
                                                  isTextCenter: false,
                                                  textColor: darkGreyColor,
                                                maxLines: 5,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              },
              child: SizedBox(
                  width: 8.w,
                  child: Image.asset(ImagesPath.chatIcon)),
            ),
            SizedBox(width: 10,),
            TextWidget1(
                text: widget.activity.comment.toString() ?? '',
                fontSize: 20.dp, fontWeight: FontWeight.w700,
                isTextCenter: false, textColor: bgColor),

          ],
        ),
      ),
    );
  }
}

//leading: CircleAvatar(
//                                       backgroundImage: NetworkImage(comment.profile!),
//                                     ),
//                                     title: Text('${comment.firstname} ${comment.lastname}'),
//                                     subtitle: Text(comment.commentText!),
//                                     // trailing: Text(comment.stamp!),