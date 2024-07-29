import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/constants/text_widget.dart';
import 'package:tiinver_project/screens/app_screens/other_user_profile_screen/other_user_profile_screen.dart';
import 'package:tiinver_project/widgets/field_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:tiinver_project/models/feedTimeLineModel/feed_time_line_model.dart';

import '../../../constants/images_path.dart';
import '../../../providers/dashboard/dashboard_provider.dart';
import '../../../providers/signIn/sign_in_provider.dart';
import '../../../widgets/image_loader_widget.dart';

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
  var formKey = GlobalKey<FormState>();

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
    var signInP = Provider.of<SignInProvider>(context,listen: false);
    final commentProvider = Provider.of<DashboardProvider>(context,listen: false);
    commentProvider.fetchComments(widget.activity.id!, signInP.userApiKey!);
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
          title: InkWell(
            onTap: () {
              if (widget.activity.isVideo()) {
                _controller.pause();
              }
              Get.to(()=>OtherUserProfileScreen(userId: widget.activity.userId!));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child:  ImageLoaderWidget(imageUrl: widget.activity.profile!),
                  ),
                ),
                SizedBox(width: 20,),
                TextWidget1(
                    text: widget.activity.username!,
                    fontSize: 18.dp,
                    fontWeight: FontWeight.w700,
                    isTextCenter: false,
                    textColor: bgColor),
              ],
            ),
          ),
      ),
      body: Center(
        child: widget.activity.isImage()
            ? Image.network(widget.activity.objectUrl!, fit: BoxFit.cover)
            : widget.activity.isVideo() && _controller.value.isInitialized
            ? InkWell(
          onTap: () {
            _controller.play();
          },child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
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
                commentProvider.fetchComments(widget.activity.id!, signInP.userApiKey!);
                Get.bottomSheet(
                  isScrollControlled: true,
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
                          height: 40.h,
                          child: StreamBuilder<List<Comment>>(
                            stream: commentProvider.commentStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No comments found.'));
                              }

                              List<Comment> comments = snapshot.data!;

                              return ListView.builder(
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  final comment = comments[index];
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 2.5.h,
                                          backgroundImage: NetworkImage(comment.profile!),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          width: 70.w,
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: lightGreyColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextWidget1(
                                                text: "${comment.firstname} ${comment.lastname}",
                                                fontSize: 10.dp,
                                                fontWeight: FontWeight.w400,
                                                isTextCenter: false,
                                                textColor: themeColor,
                                              ),
                                              TextWidget1(
                                                text: comment.commentText!,
                                                fontSize: 10.dp,
                                                fontWeight: FontWeight.w400,
                                                isTextCenter: false,
                                                textColor: darkGreyColor,
                                                maxLines: 5,
                                                overFlow: TextOverflow.ellipsis,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                          child: Consumer<DashboardProvider>(builder: (context, value, child) {
                            return Form(
                              key: formKey,
                              child: InputField(
                                inputController: value.commentC,
                                hintText: "Comment...",
                                suffixIcon: InkWell(
                                  onTap: () {
                                    log(value.commentC.text);
                                    if(value.commentC.text.isNotEmpty){
                                      value.postComment(
                                          activityId: widget.activity.id!.toString(),
                                          userId: signInP.userId.toString(),
                                          userApiKey: signInP.userApiKey.toString())
                                          .whenComplete(() {
                                        commentProvider.fetchComments(widget.activity.id!, signInP.userApiKey!);
                                        Provider.of<DashboardProvider>(context,listen: false).fetchTimeline(
                                            int.parse(signInP.userId.toString()),
                                            100, 0, signInP.userApiKey);
                                          },);
                                    }
                                  },
                                  child: value.isLoading ? SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator())
                                      : Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                      child: Image.asset(ImagesPath.sendIcon,height: 2.h,)),
                                ),
                                bdRadius: 50,
                              ),
                            );
                          },),
                        ),
                        Spacer(),
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