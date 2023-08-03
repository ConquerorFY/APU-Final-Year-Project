import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final List<dynamic> messages = [
    {'sender': "User 1", 'message': "Hello!"},
    {'sender': "User 2", 'message': "Hi there!"},
    {'sender': "User 1", 'message': "How are you?"},
    {'sender': "User 2", 'message': "I'm doing well, thanks!"},
  ];
  Settings settings = Settings();
  TextEditingController _textEditingController = TextEditingController();

  void sendMessage() {
    String message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add({'sender': "User 1", 'message': message});
        _textEditingController.clear();
      });
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

  Future<void> getData() async {
    int a = await 1;
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
                            child: Column(children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    return buildMessageBubble(
                                      messages[index]['sender'],
                                      messages[index]['message'],
                                      messages[index]['sender'] == "User 1",
                                    );
                                  },
                                ),
                              ),
                              const Divider(height: 1),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        cursorColor:
                                            settings.chatIsMeMessageBubbleColor,
                                        controller: _textEditingController,
                                        decoration:
                                            const InputDecoration.collapsed(
                                          hintText: 'Type your message...',
                                          hintStyle:
                                              TextStyle(fontFamily: 'OpenSans'),
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
                            ]));
                      },
                    ),
                    Positioned(
                      bottom: 50.0,
                      right: 16.0,
                      child: FloatingActionButton(
                        backgroundColor: settings.bottomNavBarBgColor,
                        onPressed: () {
                          // Navigate to find residents screen
                          Navigator.pushNamed(context, '/findResidents')
                              .then((_) {
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
