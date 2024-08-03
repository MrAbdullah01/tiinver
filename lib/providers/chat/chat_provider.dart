import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/chatModel/chat_model.dart';

class ChatProvider extends ChangeNotifier{

}

// class ChatProvider extends ChangeNotifier {
//
//   List<ChatRoomModel> _chatList = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//   List<ChatRoomModel> _chatRooms = [];
//
//   List<ChatRoomModel> get chatList => _chatList;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   List<ChatRoomModel> get chatRooms => _chatRooms;
//
//   Future<void> fetchChatRooms() async {
//     try {
//       var chatRoomsData = await FirebaseFirestore.instance.collection('chatRooms').get();
//       _chatRooms = chatRoomsData.docs.map((doc) {
//         var data = doc.data() as Map<String, dynamic>;
//         return ChatRoomModel.fromMap(data);
//       }).toList();
//       notifyListeners();
//     } catch (e) {
//       print("Error fetching chat rooms: $e");
//       _errorMessage = e.toString();
//       notifyListeners(); // Notify listeners even in case of error
//     }
//   }
//
//
//   Future<void> fetchChatList(String userId) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('chats')
//           .where('participants', arrayContains: userId)
//           .get();
//
//       _chatList = snapshot.docs.map((doc) {
//         var data = doc.data() as Map<String, dynamic>;
//         return ChatRoomModel.fromMap(data);
//       }).toList();
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Stream<QuerySnapshot> getMessages(String chatId) {
//     return FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp')
//         .snapshots();
//   }
//
//   Future<void> sendMessage(String chatId, String senderId, String text) async {
//     var timestamp = Timestamp.now();
//     await FirebaseFirestore.instance.collection('chats').doc(chatId).collection('messages').add({
//       'senderId': senderId,
//       'text': text,
//       'timestamp': timestamp,
//     });
//   }
//
//   // Set user to inactive after a period of inactivity
//   void setUserInactive(String userId) {
//     Future.delayed(Duration(minutes: 1), () async {
//       await _firestore.collection('users').doc(userId).update({
//         'isActive': false,
//       });
//     });
//   }
//
//   Stream<QuerySnapshot> getUserChats(String userId) {
//     return _firestore.collection('users').doc(userId).collection('chats').orderBy('createdAt', descending: true).snapshots();
//   }
//
//   Future<DocumentSnapshot> getUserDetails(String userId) {
//     return FirebaseFirestore.instance.collection('users').doc(userId).get();
//   }
//
//   Future<String> createChat(String userId1, String userId2) async {
//     String chatId = userId1.hashCode <= userId2.hashCode ? '$userId1-$userId2' : '$userId2-$userId1';
//
//     DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
//
//     if (!chatDoc.exists) {
//       await _firestore.collection('chats').doc(chatId).set({
//         'userIds': [userId1, userId2],
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//
//       await _firestore.collection('users').doc(userId1).collection('chats').doc(chatId).set({
//         'chatId': chatId,
//         'userId': userId2,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//       await _firestore.collection('users').doc(userId2).collection('chats').doc(chatId).set({
//         'chatId': chatId,
//         'userId': userId1,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//
//     return chatId;
//   }
//
// // Methods for sending images, audio, etc. will be similar
// }
