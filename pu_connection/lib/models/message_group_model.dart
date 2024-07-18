import 'package:flutter/foundation.dart';

@immutable
class MessageGroupModel {
  final String id;
  final List<String> members;
  final String groupLeader;
  final int createdAt;

  const MessageGroupModel({
    required this.id,
    required this.members,
    required this.groupLeader,
    required this.createdAt,
  });

  MessageGroupModel copyWith({
    String? id,
    List<String>? members,
    String? groupLeader,
    int? createdAt,
  }) {
    return MessageGroupModel(
      id: id ?? this.id,
      members: members ?? this.members,
      groupLeader: groupLeader ?? this.groupLeader,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'members': members,
      'groupLeader': groupLeader,
      'created_at': createdAt,
    };
  }

  factory MessageGroupModel.fromMap(Map<String, dynamic> map) {
    return MessageGroupModel(
      id: map['\$id'] ?? '',
      members: List<String>.from(map['members']),
      groupLeader: map['groupLeader'] ?? '',
      createdAt: map['created_at']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'MessageGroupModel(id: $id, members: $members, groupLeader: $groupLeader, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageGroupModel &&
        other.id == id &&
        listEquals(other.members, members) &&
        other.groupLeader == groupLeader &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        members.hashCode ^
        groupLeader.hashCode ^
        createdAt.hashCode;
  }
}
