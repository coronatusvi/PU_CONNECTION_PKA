import 'package:flutter/foundation.dart';

@immutable
class MessageModel {
  final String uid;
  final String senderId;
  final String messageText;
  final List<String> fileIds;
  final int timestamp;
  final String messageType;

  const MessageModel({
    required this.uid,
    required this.senderId,
    required this.messageText,
    required this.messageType,
    required this.fileIds,
    required this.timestamp,
  });

  MessageModel copyWith({
    String? uid,
    String? senderId,
    String? messageText,
    List<String>? fileIds,
    int? timestamp,
    String? groupId,
    String? messageType,
  }) {
    return MessageModel(
      uid: uid ?? this.uid,
      senderId: senderId ?? this.senderId,
      messageType: messageType ?? this.messageType,
      messageText: messageText ?? this.messageText,
      fileIds: fileIds ?? this.fileIds,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'senderId': senderId,
      'messageText': messageText,
      'fileIds': fileIds,
      'timestamp': timestamp,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      uid: map['\$id'] ?? '',
      senderId: map['senderId'] ?? '',
      messageType: map['messageType'] ?? '',
      messageText: map['messageText'] ?? '',
      fileIds: List<String>.from(map['fileIds']),
      timestamp: map['timestamp']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'MessageModel(uid: $uid, senderId: $senderId, messageText: $messageText,messageType: $messageType, fileIds: $fileIds, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.uid == uid &&
        other.senderId == senderId &&
        other.messageText == messageText &&
        other.messageType == messageType &&
        listEquals(other.fileIds, fileIds) &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        senderId.hashCode ^
        messageText.hashCode ^
        messageType.hashCode ^
        fileIds.hashCode ^
        timestamp.hashCode;
  }
}
