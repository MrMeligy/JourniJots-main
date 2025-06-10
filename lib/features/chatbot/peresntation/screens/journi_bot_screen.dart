import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo_impl.dart';

class JourniBotScreen extends StatefulWidget {
  const JourniBotScreen({super.key});

  @override
  State<JourniBotScreen> createState() => _JourniBotScreenState();
}

class _JourniBotScreenState extends State<JourniBotScreen> {
  final Gemini gemini = getIt<Gemini>();

  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "You",
  );

  ChatUser chatBot = ChatUser(
      id: "1",
      firstName: "JourniBot",
      profileImage:
          "https://res.cloudinary.com/dx3tixggc/image/upload/v1746241048/logo_abobqn.png");

  List<ChatMessage> messages = [];
  String interests = "";
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Add welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addWelcomeMessage();
    });
  }

  void _addWelcomeMessage() {
    setState(() {
      messages = [
        ChatMessage(
            user: chatBot,
            createdAt: DateTime.now(),
            text:
                '🏺 Welcome to your Egypt Tourism Assistant! ✨\n\nI\'m here to help you discover the magnificent wonders of Egypt - from ancient pyramids to vibrant markets, luxurious resorts to adventurous desert safaris. Ask me about:\n\n🗺️ Tourist attractions\n🍽️ Local restaurants\n🏨 Hotels & accommodations\n💡 Travel tips & insights\n\nWhat would you like to explore in Egypt today?')
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt<ProfileRepoImpl>())
        ..getProfile(
            id: getIt<CacheHelper>().getData(key: ApiKey.id.toString())),
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFB),
        appBar: _buildCustomAppBar(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffF8FAFB),
                Color(0xffF1F5F9),
              ],
            ),
          ),
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccess) {
                if (state.profileModel.interests!.isNotEmpty) {
                  interests = state.profileModel.interests.toString();
                } else {
                  interests =
                      """Nature Adventures, Local Food Experiences, Night Activities & Light Shows, Mountain Adventures & Hiking, Historic Mosques & Churches, Ancient Fortresses & Castles, Island Trips & Beach Escapes, Traditional Markets & Souvenirs, Relaxation & Resorts, Hot Air Balloon Rides, Astronomical Observations, Scuba Diving & Snorkeling, Egyptian Monuments, Desert Safari, Nubian Culture, Cultural City Tours, Historical Tourism""";
                }
              }
            },
            child: _buildUI(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: const Color.fromARGB(0, 210, 209, 209),
      centerTitle: true, // Centers the title
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff529CE0), Color(0xff3B82F6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min, // Centers the row content
        mainAxisAlignment: MainAxisAlignment.center, // Centers horizontally
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'JourniBot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your Egypt Tourism Assistant',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        if (_isTyping) _buildTypingIndicator(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DashChat(
              currentUser: currentUser,
              onSend: _sendMessage,
              messages: messages,
              messageOptions: MessageOptions(
                containerColor: const Color(0xff4A90E2),
                textColor: const Color.fromARGB(255, 71, 114, 141),
                currentUserContainerColor: const Color(0xff7BB3F0),
                currentUserTextColor: const Color.fromARGB(255, 50, 83, 100),
                borderRadius: 20,
                messagePadding: const EdgeInsets.all(16),
                messageDecorationBuilder:
                    (message, previousMessage, nextMessage) {
                  return BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 18, 137, 211)
                            .withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  );
                },
              ),
              inputOptions: InputOptions(
                inputDecoration: InputDecoration(
                  hintText: "Ask about Egypt tourism... 🏛️",
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 134, 166, 193),
                    fontSize: 16,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color(0xff529CE0),
                      width: 2,
                    ),
                  ),
                ),
                inputToolbarStyle: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 214, 214, 214)
                          .withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                inputToolbarPadding: const EdgeInsets.all(16),
              ),
              messageListOptions: const MessageListOptions(
                separatorFrequency: SeparatorFrequency.days,
                dateSeparatorBuilder: _buildDateSeparator,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildDateSeparator(DateTime date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _formatDate(date),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(chatBot.profileImage!),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(),
                const SizedBox(width: 4),
                _buildDot(),
                const SizedBox(width: 4),
                _buildDot(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
      _isTyping = true;
    });

    try {
      final prompt =
          """You are JourniBot, an expert Egypt tourism assistant. Be friendly, informative, and enthusiastic about Egypt's wonders. 

User message: ${chatMessage.text}
User interests (use if relevant): $interests

Provide helpful, accurate information about Egypt tourism including attractions, restaurants, hotels, activities, and travel tips. Use emojis appropriately to make responses engaging. Keep responses conversational and helpful.""";

      final textPart = TextPart(prompt);
      final parts = [textPart];

      final response = await gemini.prompt(parts: parts);

      setState(() {
        _isTyping = false;
        ChatMessage finalMessage = ChatMessage(
          user: chatBot,
          createdAt: DateTime.now(),
          text: response?.output ??
              "I apologize, but I'm experiencing some technical difficulties right now. Please try asking your question again! 🔧",
        );
        messages = [finalMessage, ...messages];
      });
    } catch (e) {
      setState(() {
        _isTyping = false;
        ChatMessage errorMessage = ChatMessage(
          user: chatBot,
          createdAt: DateTime.now(),
          text:
              "I'm having trouble connecting right now. Please check your internet connection and try again! 📱",
        );
        messages = [errorMessage, ...messages];
      });
      debugPrint('Error in _sendMessage: $e');
    }
  }
}
