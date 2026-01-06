import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/screens/ChatScreen.dart';


final channelsProvider = StreamProvider<List<Channel>>((ref) {
  return FirebaseFirestore.instance
      .collection('channels')
      .orderBy('createdAt', descending: false)
      .snapshots()
      .map((snapshot) {
    if (snapshot.docs.isEmpty) {
      return [];
    }
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Channel(
        id: doc.id,
        name: data['name'] ?? 'Unnamed Channel',
        description: data['description'] ?? '',
        unreadCount: data['unreadCount'] ?? 0,
        memberCount: data['memberCount'] ?? 1,
        lastActivity: (data['lastActivity'] as Timestamp?)?.toDate(),
        isPrivate: data['isPrivate'] ?? false,
        createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      );
    }).toList();
  });
});

class Channel {
  final String id;
  final String name;
  final String description;
  final int unreadCount;
  final int memberCount;
  final DateTime? lastActivity;
  final bool isPrivate;
  final DateTime? createdAt;

  Channel({
    required this.id,
    required this.name,
    required this.description,
    required this.unreadCount,
    required this.memberCount,
    this.lastActivity,
    required this.isPrivate,
    this.createdAt,
  });
}

final currentChannelProvider = StateProvider<String>((ref) => '');

List<Message> _groupMessages(List<Message> messages) {
  if (messages.isEmpty) return messages;

  final List<Message> grouped = [];

  for (int i = 0; i < messages.length; i++) {
    final current = messages[i];

    if (i > 0) {
      final previous = messages[i - 1];
      final timeDiff = current.timestamp.difference(previous.timestamp);

      if (current.senderId == previous.senderId &&
          timeDiff.inMinutes < 5) {
        grouped.add(Message(
          id: current.id,
          text: current.text,
          senderId: current.senderId,
          senderName: current.senderName,
          senderEmail: current.senderEmail,
          timestamp: current.timestamp,
          isSent: current.isSent,
          reactions: current.reactions,
          showHeader: false,
        ));
        continue;
      }
    }

    grouped.add(Message(
      id: current.id,
      text: current.text,
      senderId: current.senderId,
      senderName: current.senderName,
      senderEmail: current.senderEmail,
      timestamp: current.timestamp,
      isSent: current.isSent,
      reactions: current.reactions,
      showHeader: true,
    ));
  }

  return grouped;
}

final messagesProvider = StreamProvider.family<List<Message>, String>((ref, channelId) {
  return FirebaseFirestore.instance
      .collection('channels')
      .doc(channelId)
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots()
      .map((snapshot) {
    final messages = snapshot.docs.map((doc) {
      final data = doc.data();
      return Message(
        id: doc.id,
        text: data['text'] ?? '',
        senderId: data['senderId'] ?? '',
        senderName: data['senderName'] ?? 'Unknown',
        senderEmail: data['senderEmail'] ?? '',
        timestamp: (data['timestamp'] as Timestamp).toDate(),
        isSent: true,
        reactions: Map<String, dynamic>.from(data['reactions'] ?? {}),
      );
    }).toList();

    // Group messages by user
    return _groupMessages(messages);
  });
});