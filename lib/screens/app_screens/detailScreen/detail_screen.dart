import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
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

class DetailScreen extends StatelessWidget {

  final Activity activity;

  final List<Activity> activities;

  DetailScreen({
    super.key,
    required this.activity,
    required this.activities
  });

  late VideoPlayerController _controller;

  late Future<List<Comment>> _commentsFuture;

  var formKey = GlobalKey<FormState>();

  // @override
  @override
  Widget build(BuildContext context) {
    var signInProvider  = Provider.of<SignInProvider>(context,listen: false);
    final dashboardProvider = Provider.of<DashboardProvider>(context,listen: false);
    dashboardProvider.fetchComments(activity.id!, signInProvider.userApiKey!);
    return Scaffold(
      backgroundColor: textColor,
      appBar:  AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: false,
        title: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            final activity = activities[provider.currentPage];

            return AppBar(
              backgroundColor: textColor,
              surfaceTintColor: textColor,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: bgColor),
              ),
              title: InkWell(
                onTap: () {
                  if (activity.isVideo()) {
                    // Pause video if playing
                  }
                  Get.to(() => OtherUserProfileScreen(userId: activity.userId!));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: Connectivity().checkConnectivity(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.data == ConnectivityResult.none) {
                          return Icon(Icons.wifi_off);
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: ImageLoaderWidget(imageUrl: activity.profile!),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 40.w,
                      child: TextWidget1(
                        text: activity.username!,
                        fontSize: 18.dp,
                        fontWeight: FontWeight.w700,
                        isTextCenter: false,
                        textColor: bgColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: PageView.builder(
        controller: dashboardProvider.pageController,
        itemCount: activities.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final activity = activities[index];

          return Stack(
            children: [
              Center(
                child: activity.isImage()
                    ? Image.network(activity.objectUrl!, fit: BoxFit.cover)
                    : activity.isVideo()
                    ? VideoPlayerScreen(activity: activity)
                    : Container(
                  height: 100.h,
                  width: 100.w,
                  color: lightGreyColor,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  children: [
                    SizedBox(
                      width: 8.w,
                      child: Image.asset(
                        ImagesPath.likeIcon,
                        color: activity.isLiked! ? Colors.red : bgColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    TextWidget1(
                      text: "${activity.likes ?? ''}",
                      fontSize: 20.dp,
                      fontWeight: FontWeight.w700,
                      isTextCenter: false,
                      textColor: bgColor,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        var commentProvider = Provider.of<DashboardProvider>(context, listen: false);
                        commentProvider.fetchComments(activity.id!, signInProvider.userApiKey!);
                        Get.bottomSheet(
                          isScrollControlled: true,
                          Container(
                            height: 50.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 1.5.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                  child: Consumer<DashboardProvider>(
                                    builder: (context, value, child) {
                                      return Form(
                                        key: formKey,
                                        child: InputField(
                                          inputController: value.commentC,
                                          hintText: "Comment...",
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              if (value.commentC.text.isNotEmpty) {
                                                value.postComment(
                                                  activityId: activity.id!.toString(),
                                                  userId: signInProvider.userId.toString(),
                                                  userApiKey: signInProvider.userApiKey.toString(),
                                                ).whenComplete(() {
                                                  commentProvider.fetchComments(activity.id!, signInProvider.userApiKey!);
                                                  Provider.of<DashboardProvider>(context, listen: false)
                                                      .fetchTimeline(
                                                    int.parse(signInProvider.userId.toString()),
                                                    100,
                                                    0,
                                                    signInProvider.userApiKey,
                                                  );
                                                });
                                              }
                                            },
                                            child: value.isLoading
                                                ? SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(),
                                            )
                                                : Container(
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                              child: Image.asset(
                                                ImagesPath.sendIcon,
                                                height: 2.h,
                                              ),
                                            ),
                                          ),
                                          bdRadius: 50,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 8.w,
                        child: Image.asset(ImagesPath.chatIcon),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextWidget1(
                      text: activity.comment.toString() ?? '',
                      fontSize: 20.dp,
                      fontWeight: FontWeight.w700,
                      isTextCenter: false,
                      textColor: bgColor,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final Activity activity;

  const VideoPlayerScreen({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..initialize(activity.objectUrl!),
      child: Consumer<DashboardProvider>(
        builder: (context, videoProvider, child) {
          return GestureDetector(
            onTap: () {
              if (videoProvider.controller.value.isPlaying) {
                videoProvider.controller.pause();
              } else {
                videoProvider.controller.play();
              }
            },
            child:  AspectRatio(
              aspectRatio: videoProvider.controller.value.aspectRatio,
              child: VideoPlayer(videoProvider.controller),
            ),
            // videoProvider.controller.value.isInitialized
            //     ?
            //     : Container(
            //   height: 200.0,
            //   color: Colors.grey,
            //   child: Center(child: CircularProgressIndicator()),
            // ),
          );
        },
      ),
    );
  }
}