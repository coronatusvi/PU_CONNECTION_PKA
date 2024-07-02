import 'package:flutter/foundation.dart';

@immutable
class Message {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String messageText;
  final List<String> fileIds;
  final int timestamp;

  const Message({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.messageText,
    required this.fileIds,
    required this.timestamp,
  });

  Message copyWith({
    String? messageId,
    String? senderId,
    String? receiverId,
    String? messageText,
    List<String>? fileIds,
    int? timestamp,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      messageText: messageText ?? this.messageText,
      fileIds: fileIds ?? this.fileIds,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'messageId': messageId});
    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'messageText': messageText});
    result.addAll({'fileIds': fileIds});
    result.addAll({'timestamp': timestamp});

    return result;
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      messageText: map['messageText'] ?? '',
      fileIds: List<String>.from(map['fileIds']),
      timestamp: map['timestamp']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'Message(messageId: $messageId, senderId: $senderId, receiverId: $receiverId, messageText: $messageText, fileIds: $fileIds, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.messageId == messageId &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.messageText == messageText &&
        listEquals(other.fileIds, fileIds) &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        messageText.hashCode ^
        fileIds.hashCode ^
        timestamp.hashCode;
  }
}
