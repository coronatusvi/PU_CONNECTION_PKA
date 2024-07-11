import 'package:flutter/foundation.dart';

@immutable
class MessageModel {
  final String messageId;
  final String senderId;
  final String messageText;
  final List<String> fileIds;
  final int timestamp;
  final String groupId;

  const MessageModel({
    required this.messageId,
    required this.senderId,
    required this.messageText,
    required this.fileIds,
    required this.timestamp,
    required this.groupId,
  });

  MessageModel copyWith({
    String? messageId,
    String? senderId,
    String? messageText,
    List<String>? fileIds,
    int? timestamp,
    String? groupId,
  }) {
    return MessageModel(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      messageText: messageText ?? this.messageText,
      fileIds: fileIds ?? this.fileIds,
      timestamp: timestamp ?? this.timestamp,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'messageId': messageId});
    result.addAll({'senderId': senderId});
    result.addAll({'messageText': messageText});
    result.addAll({'fileIds': fileIds});
    result.addAll({'timestamp': timestamp});
    result.addAll({'groupId': groupId});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      senderId: map['senderId'] ?? '',
      messageText: map['messageText'] ?? '',
      fileIds: List<String>.from(map['fileIds']),
      timestamp: map['timestamp']?.toInt() ?? 0,
      groupId: map['groupId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'MessageModel(messageId: $messageId, senderId: $senderId, messageText: $messageText, fileIds: $fileIds, timestamp: $timestamp, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.messageId == messageId &&
        other.senderId == senderId &&
        other.messageText == messageText &&
        listEquals(other.fileIds, fileIds) &&
        other.timestamp == timestamp &&
        other.groupId == groupId;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
        senderId.hashCode ^
        messageText.hashCode ^
        fileIds.hashCode ^
        timestamp.hashCode ^
        groupId.hashCode;
  }
}
