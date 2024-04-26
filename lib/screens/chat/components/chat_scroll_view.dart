import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:llm_api/constants/colors.dart';
import 'package:llm_api/providers/messaging_provider.dart';
import 'package:llm_api/widgets/message_bubble.dart';
import 'package:provider/provider.dart';

class ChatScrollView extends StatefulWidget {
  const ChatScrollView({super.key});

  @override
  State<ChatScrollView> createState() => _ChatScrollViewState();
}

class _ChatScrollViewState extends State<ChatScrollView> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final messagingProvider = context.watch<MessagingProvider>();

    if (messagingProvider.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/cgpt.svg', height: 200),
            const Text(
              'How can I help you?',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    return ListView.separated(
      controller: _scrollController,
      itemCount: messagingProvider.messages.length,
      itemBuilder: (context, index) {
        final message = messagingProvider.messages[index];
        return MessageBubble(message: message);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 30),
    );
  }
}
