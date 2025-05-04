import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/widgets/custom_appbar.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo_impl.dart';

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
  String interests = "";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt<ProfileRepoImpl>())
        ..getProfile(
            id: getIt<CacheHelper>().getData(key: ApiKey.id.toString())),
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: const CustomAppBar(
          title: "JourniBot",
          color: Color(0xff529CE0),
          titleColor: Color(0xffFFFFFF),
          iconColor: Color(0xffFFFFFF),
          icon: false,
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              if (state.profileModel.interests!.isNotEmpty) {
                interests = state.profileModel.interests.toString();
              } else {
                interests = """Nature Adventures
Local Food Experiences
Night Activities & Light Shows
Mountain Adventures & Hiking
Historic Mosques & Churches
Ancient Fortresses & Castles
Island Trips & Beach Escapes
Traditional Markets & Souvenirs
Relaxation & Resorts
Hot Air Balloon Rides
Astronomical Observations
Scuba Diving & Snorkeling
Egyptian Monuments
Desert Safari
Nubian Culture
Cultural City Tours
Historical Tourism""";
              }
            }
          },
          child: _buildUI(),
        ),
      ),
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
          "You are a smart assistant your name is JourniBot specialized only in tourism in Egypt and help tourists. If a user asks a question that is not related to tourism in Egypt or restaurants or hotels or acitivities in egypt  (such as topics about technology, sports, or other countries), politely respond that you cannot help with that because your expertise is limited to tourism in Egypt. if user ask to recommend or about restaurant or hotel or activity answer that u can search on journiJots application (not journibot journibot is your name) in your city about it and check ratings So the user Question is: ${chatMessage.text} my interests if you need it is $interests";

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
