import 'package:flutter/material.dart';
import '../core/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentuser;

  const MessageBubble({
    required this.message,
    required this.belongsToCurrentuser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentuser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: belongsToCurrentuser
                  ? Colors.grey.shade300
                  : Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              )),
          width: 180,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Text(
                message.userName,
                style: TextStyle(
                  color: belongsToCurrentuser ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(message.text,
                style: TextStyle(
                  color: belongsToCurrentuser ? Colors.black : Colors.white,
                ),),
            ],
          ),
        ),
      ],
    );
  }
}
