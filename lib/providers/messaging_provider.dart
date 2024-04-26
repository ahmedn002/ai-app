import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:llm_api/entities/message.dart';

class MessagingProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  bool loading = false;

  Future<void> addMessage(Message message) async {
    _messages.add(message);
    notifyListeners();
  }

  void prompt(String message) async {
    addMessage(Message(
      content: message,
      isUser: true,
    ));

    loading = true;
    notifyListeners();

    final Message response = await _getResponse(message);

    loading = false;
    addMessage(response);
  }

  Future<Message> _getResponse(String message) async {
    // return Message(content: 'Hello, World!', isUser: false);

    const String endpoint = 'https://api.deepinfra.com/v1/inference/meta-llama/Llama-2-70b-chat-hf';
    const String apiKey = 'DixaPdejr5UEp7b3LomlSbVuzOMpRqcV';

    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final Map<String, dynamic> body = {
      'input': '[INST] $message [/INST]',
    };

    final Response response = await _dio.post(
      endpoint,
      data: body,
      options: Options(headers: headers),
    );
    print(response);
    // Strip leading and trailing empty spaces
    final String output = (response.data['results'][0]['generated_text'] as String).trim();
    print(output);

    return Message(content: output, isUser: false);
  }
}
