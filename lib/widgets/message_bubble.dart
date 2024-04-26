import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llm_api/constants/colors.dart';
import 'package:llm_api/entities/message.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  const MessageBubble({super.key, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> with AutomaticKeepAliveClientMixin {
  bool _built = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Widget content = Row(
      mainAxisAlignment: widget.message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!widget.message.isUser) CircleAvatar(backgroundColor: AppColors.darkerAccent, child: SvgPicture.asset('assets/cgpt.svg')),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: widget.message.isUser ? AppColors.darkerAccent : AppColors.darkerBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              widget.message.content,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (widget.message.isUser)
          const CircleAvatar(
            backgroundColor: AppColors.tertiaryText,
            child: Icon(
              Icons.person,
              color: AppColors.background,
            ),
          ),
      ],
    );

    if (!_built) {
      _built = true;
      return Animate(
        effects: [
          SlideEffect(
            begin: const Offset(0, 1),
            end: Offset.zero,
            duration: 750.ms,
            curve: Curves.easeOutExpo,
          ),
          FadeEffect(
            begin: 0,
            end: 1,
            duration: 750.ms,
            curve: Curves.easeOutExpo,
          )
        ],
        child: content,
      );
    }

    return content;
  }
}
