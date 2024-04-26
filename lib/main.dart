import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:llm_api/providers/messaging_provider.dart';
import 'package:llm_api/screens/chat/chat_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  sendRequest();
}

Future<void> sendRequest() async {
  const String prompt = 'Hello.';

  // -H "Content-Type: application/json" \
  // -H "Authorization: Bearer $(deepctl auth token)"

  const String endpoint = 'https://api.deepinfra.com/v1/inference/meta-llama/Llama-2-70b-chat-hf';
  const String apiKey = 'DixaPdejr5UEp7b3LomlSbVuzOMpRqcV';

  final Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  final Map<String, dynamic> body = {
    'input': '[INST] $prompt [/INST]',
  };

  final Dio dio = Dio();

  final Response response = await dio.post(
    endpoint,
    data: body,
    options: Options(headers: headers),
  );

  print(response.data);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MessagingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const ChatScreen(),
      ),
    );
  }
}
