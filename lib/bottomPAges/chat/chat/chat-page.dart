import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat-bubble.dart';
import 'chat-model.dart';

class ChatViewPage extends StatefulWidget {
  @override
  _ChatViewPageState createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> with SingleTickerProviderStateMixin {
  TextEditingController textMessage = TextEditingController();
  ScrollController _scrollController = ScrollController();
  TabController tabController;
  Color accentColor = Color(0xff313f53);

  @override
  void initState() {
    super.initState();
     tabController = TabController(vsync: this,length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: accentColor,
        centerTitle: true,
        title: Text('Robin Smith',style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.call),
              onPressed: (){
                //launch("tel:+923472363720");
              },
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.only(right: 20.0),
//            child: CircleAvatar(
//              child: Image.asset('assets/images/scaffolding.png'),
//            ),
//          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context,i){

                  bool isFirstSender = i==0 ? true: !chatMessages[i-1].me;
                  bool isFirstReceiver = i==0 ? true : chatMessages[i-1].me;


                  return Bubble(
                    isFirstSender: isFirstSender,
                    isFirstReceiver: isFirstReceiver,
                    time: ((DateTime date) =>
                    "${date.hour % 12}:${date.minute} ${date.hour > 12
                        ? 'PM'
                        : 'AM'}")(
                        DateTime.now()),
                    isMe: chatMessages[i].me,
                    message: chatMessages[i].message,
                  );
                },
                itemCount: chatMessages.length,
              )
          ),
          Container(
            color: accentColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 8.0),
                    child: Material(
                      elevation: 1,
                      child: TextFormField(
                        controller: textMessage,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 13.0, bottom: 13.0, left: 20),
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.black54),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                              BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    iconSize: 25,
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: ()  {
                      textMessage.text.isNotEmpty ?  setState(() {
                        chatMessages.add(ChatModel(
                            me: true,
                            message: textMessage.text
                        ));
                        textMessage.clear();
                      }): Container();
                        _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: Duration(milliseconds: 300),
                      );
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}