import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../core/providers/channel_provider.dart';
import '../features/screens/ChatScreen.dart';


class ChannelListItem extends ConsumerWidget {
  final Channel channel;

  const ChannelListItem({super.key, required this.channel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentChannelId = ref.watch(currentChannelProvider);
    final isActive = currentChannelId == channel.id;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isActive
              ? const Color(0xFF4A154B)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4A154B),
                Color(0xFF611F69),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            channel.isPrivate ? Icons.lock : Icons.tag,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Text(
              channel.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isActive
                    ? const Color(0xFF4A154B)
                    : Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            if (channel.isPrivate) ...[
              const SizedBox(width: 8),
              const Icon(Icons.lock, size: 14, color: Colors.grey),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              channel.description.isNotEmpty
                  ? channel.description
                  : 'No description',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.people_outline, size: 12),
                const SizedBox(width: 4),
                Text(
                  '${channel.memberCount} members',
                  style: const TextStyle(fontSize: 11),
                ),
                if (channel.lastActivity != null) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.schedule, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    _formatLastActivity(channel.lastActivity!),
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: channel.unreadCount > 0
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            channel.unreadCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : null,
        onTap: () {
          ref.read(currentChannelProvider.notifier).state = channel.id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(channelId: channel.id),
            ),
          );
        },
      ),
    );
  }

  String _formatLastActivity(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return DateFormat('MMM d').format(dateTime);
  }
}

