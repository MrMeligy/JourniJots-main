import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/widgets/custom_appbar.dart';

class JourniBotScreen extends StatefulWidget {
  const JourniBotScreen({super.key});

  @override
  State<JourniBotScreen> createState() => _JourniBotScreenState();
}

class _JourniBotScreenState extends State<JourniBotScreen> {
  final Gemini gemini = getIt<Gemini>();
  ChatUser currentUser = ChatUser(id: "0", firstName: "user");
  ChatUser chatBot = ChatUser(
      id: "1",
      firstName: "JourniBot",
      profileImage:
          "https://res.cloudinary.com/dx3tixggc/image/upload/v1746241048/logo_abobqn.png");
  List<ChatMessage> messages = [
    ChatMessage(
        user: ChatUser(
            id: "1",
            firstName: "JourniBot",
            profileImage:
                "https://res.cloudinary.com/dx3tixggc/image/upload/v1746241048/logo_abobqn.png"),
        createdAt: DateTime.now(),
        text:
            'Welcome to the Egypt Tourism Assistant! I can help you discover the wonders of Egypt including attractions, restaurants, hotels, and travel tips across all Egyptian cities.')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: const CustomAppBar(
        title: "JourniBot",
        color: Color(0xff529CE0),
        titleColor: Color(0xffFFFFFF),
        iconColor: Color(0xffFFFFFF),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.04),
      child: DashChat(
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages,
        messageOptions: const MessageOptions(
          containerColor: Color(0xffD9D9D9),
        ),
        inputOptions: const InputOptions(
          inputDecoration: InputDecoration(
            hintText: "Ask about Egypt tourism...",
            hintStyle: TextStyle(
              color: Color(0xff535353),
            ),
            fillColor: Color(0xffC6BDBD),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      final prompt =
          "You are a smart assistant specialized only in tourism in Egypt. If a user asks a question that is not related to tourism in Egypt (such as topics about technology, sports, or other countries), politely respond that you cannot help with that because your expertise is limited to tourism in Egypt. So the user Question is: ${chatMessage.text}";

      ChatMessage loadingMessage = ChatMessage(
        user: chatBot,
        createdAt: DateTime.now(),
        text: "typing....",
      );

      setState(() {
        messages = [loadingMessage, ...messages];
      });

      final textPart = TextPart(prompt);
      final parts = [textPart];

      final response = await gemini.prompt(parts: parts);

      setState(() {
        messages.removeAt(0);
        ChatMessage finalMessage = ChatMessage(
          user: chatBot,
          createdAt: DateTime.now(),
          text: response!.output ??
              "there is a problem right now ", // response هنا هي نص جاهز مباشرة
        );
        messages = [finalMessage, ...messages];
      });
    } catch (e) {
      setState(() {
        if (messages.isNotEmpty && messages[0].user == chatBot) {
          messages.removeAt(0);
        }
        ChatMessage errorMessage = ChatMessage(
          user: chatBot,
          createdAt: DateTime.now(),
          text: "There is A problem Right Now",
        );
        messages = [errorMessage, ...messages];
      });
      // ignore: avoid_print
      print(e);
    }
  }
}
