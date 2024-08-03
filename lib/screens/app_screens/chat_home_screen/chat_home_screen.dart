// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:tiinver_project/constants/colors.dart';
// import 'package:tiinver_project/constants/text_widget.dart';
// import 'package:tiinver_project/widgets/field_widget.dart';
//
//  // Import your ChatProvider class
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../../../models/chatModel/chat_model.dart';
// import '../../../models/userModel/user_model.dart';
// import '../../../providers/chat/chat_provider.dart';
// import '../chat_screen/chat_screen.dart';
//
// class ChatHomeScreen extends StatelessWidget {
//   const ChatHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     var searchC = TextEditingController();
//
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: SafeArea(
//         child: Container(
//           // margin: EdgeInsets.only(top: Get.width * 0.450),
//           decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               )
//           ),
//           child: Column(
//             children: [
//               InputField(
//                   inputController: searchC,
//                 hintText: "Search",
//
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     TextWidget1(text: "Messages", fontSize: 16.0,fontWeight: FontWeight.bold,textColor: themeColor,isTextCenter: false,),
//                   ],
//                 ),
//               ),
//               Consumer<ChatProvider>(
//                 builder: (context, chatProvider, _) {
//                   return StreamBuilder<List<ChatRoomModel>>(
//                     stream: chatProvider.getChatRoomsStream(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const  Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return const  Center(
//                           child: Text('No chats available'),
//                         );
//                       }
//                       var chatRooms = snapshot.data!;
//                       return ListView.separated(
//                         itemCount: snapshot.data!.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           final chatRoom = chatRooms[index];
//                           final unreadCount =  chatProvider.unreadMessageCounts[chatRoom.id] ?? 0;
//                           var otherUserEmail = chatRoom.users.firstWhere((user) => user != chatProvider.userEmail);
//                           var lastMessage = chatRoom.lastMessage;
//                           // var timeStamp = chatRoom[index].lastTimestamp;
//
//
//                           log("message $unreadCount");
//                           // final relativeTime = timeStamp != null
//                           //     ? timeago.format(timeStamp.toDate())
//                           //     : '';
//
//                           log("ChatListScreen:: ${chatProvider.users} ${otherUserEmail}");
//
//                           log("ChatListScreen:: ${chatProvider.users.firstWhere(
//                                   (user) => user.email == otherUserEmail,
//                               orElse: () => UserModel(id: '', firstname: 'Unknown', email: otherUserEmail, profile: ''))}");
//
//                           // Retrieve user information from ChatProvider
//                           var otherUser =  chatProvider.users.firstWhere(
//                                 (user) => user.email == otherUserEmail,
//                             orElse: () => UserModel(id: '', firstname: 'Unknown', email: otherUserEmail, profile: ''), // Default user
//                           );
//
//                           log("message ${otherUser.profile}");
//                           return ListTile(
//                             leading: CircleAvatar(
//                               backgroundImage: NetworkImage(otherUser.profile), // Assuming image is a URL
//                             ),
//                             title: TextWidget(text: otherUser.firstname,size: 14.0,color: Colors.black,isBold: true),
//                             // title: Text(otherUserEmail),
//                             subtitle: TextWidget(text: lastMessage.toString(),size: 12.0,color: Colors.black,),
//                             trailing: chatRoom.isMessage == "auth.currentUser!.email" && chatRoom.isMessage !="seen"
//                                 ? const CircleAvatar(
//                               radius: 7,
//                               backgroundColor: themeColor,
//                             )
//                                 : null,
//                             onTap: () async{
//                               final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(otherUser.email,"");
//                               Provider.of<ChatProvider>(context,listen: false).updateMessageStatus(chatRoomId);
//                               Get.to(ChatScreen(
//                                 userUID: "product.userUID",
//                                 name: otherUser.firstname,
//                                 image: otherUser.profile,
//                                 otherEmail: otherUser.email,
//                                 chatRoomId: chatRoomId,
//                               ));
//                               await chatProvider.getUnreadMessageCount(chatRoom.id);
//                               log("message ${ chatProvider.getUnreadMessageCount(chatRoom.id).toString()}");
//
//                               // await chatProvider.getCollectionLength(chatRoom.id);
//                               // log('get Messages ${chatProvider.collectionLength}');
//
//                             },
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return const Divider(
//                             color: Colors.black,
//                           );
//                         },
//                       );
//
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// class TextWidget extends StatelessWidget {
//   final String text;
//   Color color;
//   final double size;
//   bool isBold;
//   var fontFamily,textAlignment;
//   bool italic;
//   int maxLine;
//
//   TextWidget(
//       {
//         required this.text,
//         this.color = Colors.black,
//         required this.size,
//         this.isBold = false,
//         this.fontFamily = '',
//         this.textAlignment = TextAlign.start,
//         this.italic = false,
//         this.maxLine = 100
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       softWrap: true,
//       maxLines: maxLine,
//       // overflow: TextOverflow.ellipsis,
//       style: TextStyle(
//         color: color,
//         fontSize: size,
//         fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//         fontStyle: italic ? FontStyle.italic : FontStyle.normal,
//         fontFamily: fontFamily,
//       ),
//       textAlign: textAlignment,
//     );
//   }
// }

//ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: 2,
//               itemBuilder: (context, index) {
//               return ChatTile(
//                   name: "Reminder",
//                   chatText: "Hello",
//                   lastMsgTime: "01:45 PM",
//                   tapAction: (){
//                     Get.to(()=>ChatScreen());
//                   },
//                   image: ImagesPath.profileImage);
//             },)

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:tiinver_project/providers/signIn/sign_in_provider.dart';
import 'package:tiinver_project/screens/app_screens/invite_contact_screen/invite_contact_screen.dart';
import 'package:tiinver_project/widgets/header.dart';
import '../../../constants/colors.dart';
import '../../../firebase/chat/firebase_chat.dart';
import '../../../models/chatModel/chat_model.dart';
import '../../../providers/chat/chat_provider.dart';
import '../chat_screen/chat_screen.dart';
import 'comp/chat_tile.dart';

class ChatListScreen extends StatefulWidget {

  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  List<ChatUser> _list = [];


  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context,listen: false);
    final signInP = Provider.of<SignInProvider>(context,listen: false);

    // if (signInP.userId != null) {
    //   chatProvider.fetchChatList(signInP.userId.toString());
    // }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header().header1("Chats", [], isIconShow: false,isCenterTitle: true),
      body: StreamBuilder(
        stream: FirebaseChat.getMyContactsUid(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return StreamBuilder(
                stream: FirebaseChat.getAllUsers(
                    snapshot.data?.docs.map((e) => e.id).toList() ?? []),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      _list = data
                          ?.map((e) => ChatUser.fromJson(e.data()))
                          .toList() ??
                          [];

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                            itemCount: _list.length,
                            padding: EdgeInsets.only(top: 1.0.h),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ChatUserCard(user: _list[index]);
                            });
                      } else {
                        return const Center(
                          child: Text('No Connections Found!',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          ),
          child: Icon(Icons.add_rounded,color: bgColor,size: 30.dp,),
          backgroundColor: themeColor,
          onPressed: (){
            Get.to(()=>InviteContactScreen());
            // Random random = Random();
            //
            // int msgId = random.nextInt(1000000000);
            // debugPrint(msgId.toString());
          }
      ),
    );
  }
}


