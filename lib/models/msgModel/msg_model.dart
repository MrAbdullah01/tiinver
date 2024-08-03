enum Type { text, image, voice, audio }

class Message {
  Message({
    required this.toUserUid,
    required this.message,
    required this.read,
    required this.type,
    required this.fromUserUid,
    required this.sent,
  });

  final String toUserUid;
  final String message;
  final String read;
  final String fromUserUid;
  final String sent;
  final Type type;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      toUserUid: json['toUserUid'] as String,
      message: json['message'] as String,
      read: json['read'] as String,
      fromUserUid: json['fromUserUid'] as String,
      sent: json['sent'] as String,
      type: Type.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => Type.text,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'toUserUid': toUserUid,
      'message': message,
      'read': read,
      'type': type.name,
      'fromUserUid': fromUserUid,
      'sent': sent,
    };
  }
}

// enum MessageType { user, bot }
//
// class AiMessage {
//   AiMessage({
//     required this.msg,
//     required this.msgType,
//   });
//
//   final String msg;
//   final MessageType msgType;
// }