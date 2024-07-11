import 'package:flutter/foundation.dart';

@immutable
class MessageGroupModel {
  final String groupId;
  final List<String> members;
  final String groupLeader;
  final int createdAt;

  const MessageGroupModel({
    required this.groupId,
    required this.members,
    required this.groupLeader,
    required this.createdAt,
  });

  MessageGroupModel copyWith({
    String? groupId,
    List<String>? members,
    String? groupLeader,
    int? createdAt,
  }) {
    return MessageGroupModel(
      groupId: groupId ?? this.groupId,
      members: members ?? this.members,
      groupLeader: groupLeader ?? this.groupLeader,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'groupId': groupId});
    result.addAll({'members': members});
    result.addAll({'groupLeader': groupLeader});
    result.addAll({'createdAt': createdAt});

    return result;
  }

  factory MessageGroupModel.fromMap(Map<String, dynamic> map) {
    return MessageGroupModel(
      groupId: map['groupId'] ?? '',
      members: List<String>.from(map['members']),
      groupLeader: map['groupLeader'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'MessageGroupModel(groupId: $groupId, members: $members, groupLeader: $groupLeader, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageGroupModel &&
        other.groupId == groupId &&
        listEquals(other.members, members) &&
        other.groupLeader == groupLeader &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return groupId.hashCode ^
        members.hashCode ^
        groupLeader.hashCode ^
        createdAt.hashCode;
  }
}
