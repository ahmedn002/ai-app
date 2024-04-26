import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llm_api/constants/colors.dart';
import 'package:llm_api/providers/messaging_provider.dart';
import 'package:llm_api/screens/chat/components/chat_scroll_view.dart';
import 'package:llm_api/widgets/input_field.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.darkerBackground,
        elevation: 0,
        title: SvgPicture.asset('assets/logo.svg'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Expanded(child: ChatScrollView()),
            const SizedBox(height: 20),
            TextInput(
              controller: _controller,
              hintText: 'What do you want to ask about?',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/cgpt.svg'),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 7, 4),
                child: Consumer<MessagingProvider>(builder: (context, messagingProvider, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: AppColors.darkerAccent,
                      child: InkWell(
                        onTap: () {
                          if (_controller.text.isNotEmpty) {
                            messagingProvider.prompt(_controller.text);
                            _controller.clear();
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: FittedBox(
                          child: messagingProvider.loading
                              ? Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 30,
                                  height: 30,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.primaryText,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.fromLTRB(7, 8, 7, 6),
                                  child: SvgPicture.asset('assets/send.svg'),
                                ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
