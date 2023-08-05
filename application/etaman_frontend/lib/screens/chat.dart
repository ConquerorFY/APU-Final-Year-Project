import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  List<dynamic> messages = [];
  Settings settings = Settings();
  ApiService apiService = ApiService();
  AuthService authService = AuthService();
  final TextEditingController _chatController = TextEditingController();
  dynamic selectedResidentID;
  dynamic loggedInResidentID;

  @override
  void initState() {
    super.initState();
    getLoggedInResidentID();
  }

  Future<void> getLoggedInResidentID() async {
    final responseData = await apiService
        .getResidentDataAPI({"token": authService.getAuthToken()});
    if (responseData != null) {
      final status = responseData['status'];
      if (status > 0) {
        // Success
        setState(() {
          loggedInResidentID = responseData['data']['list']['id'];
        });
      }
    }
  }

  Future<void> getData() async {
    final responseData = await apiService.getChatHistory(
        {'token': authService.getAuthToken(), 'receiver': selectedResidentID});
    if (responseData != null) {
      final status = responseData['status'];
      if (status > 0) {
        // Success
        dynamic chats = responseData['data']['list'];
        chats.sort((a, b) => a['previous'].compareTo(b['previous']) as int);
        setState(() {
          messages = chats;
        });
      }
    }
  }

  void sendMessage() async {
    String message = _chatController.text.trim();
    if (message.isNotEmpty) {
      // Ensure that the message is not empty
      Map<String, dynamic> chatData = {
        "receiver": selectedResidentID,
        "content": message,
        "token": authService.getAuthToken(),
      };
      if (messages.isNotEmpty) {
        chatData['previous'] = messages.last['id'];
      }
      final chatResponse = await apiService.submitChatMessage(chatData);
      if (chatResponse != null) {
        final status = chatResponse['status'];
        if (status > 0) {
          // Success
          getData();
          _chatController.clear();
        }
      }
    }
  }

  Widget buildMessageBubble(String sender, String message, bool isMe) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 10.0,
                  color: settings.chatMessageBubbleLabelColor,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
            decoration: BoxDecoration(
              color: isMe
                  ? settings.chatIsMeMessageBubbleColor
                  : settings.chatNotMeMessageBubbleColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(message,
                style: TextStyle(
                    fontFamily: "OpenSans",
                    color: settings.chatMessageBubbleTextColor,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(isImplyLeading: false),
        body: RefreshIndicator(
            onRefresh: getData,
            color: settings.loadingBgColor,
            child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Stack(children: [
                    Builder(
                      builder: (BuildContext innerContext) {
                        return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity! < 0) {
                                Scaffold.of(innerContext).openDrawer();
                              }
                            },
                            child: selectedResidentID != null
                                ? Column(children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: messages.length,
                                        itemBuilder: (context, index) {
                                          return buildMessageBubble(
                                            messages[index]['senderUsername'],
                                            messages[index]['content'],
                                            messages[index]['sender'] ==
                                                loggedInResidentID,
                                          );
                                        },
                                      ),
                                    ),
                                    const Divider(height: 1),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              cursorColor: settings
                                                  .chatIsMeMessageBubbleColor,
                                              controller: _chatController,
                                              decoration: const InputDecoration
                                                  .collapsed(
                                                hintText:
                                                    'Type your message...',
                                                hintStyle: TextStyle(
                                                    fontFamily: 'OpenSans'),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.send,
                                                color: settings.chatIconColor),
                                            onPressed: sendMessage,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])
                                : Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.white,
                                    child: Center(
                                        child: Text("No residents selected!",
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: settings
                                                    .chatIsMeMessageBubbleColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700))),
                                  ));
                      },
                    ),
                    Positioned(
                      bottom: 50.0,
                      right: 16.0,
                      child: FloatingActionButton(
                        backgroundColor: settings.bottomNavBarBgColor2,
                        hoverColor: settings.bottomNavBarBgColor,
                        onPressed: () async {
                          // Navigate to find residents screen
                          dynamic receivedData = await Navigator.pushNamed(
                              context, '/findResidents');
                          setState(() {
                            selectedResidentID = receivedData['receiverID'];
                            getData();
                          });
                        },
                        child: Icon(Icons.search,
                            color: settings.bottomNavBarTextColor),
                      ),
                    )
                  ]);
                })),
        drawer: const LeftDrawer(),
        bottomNavigationBar: BottomNavBar(selectedIndex: 3));
  }
}
