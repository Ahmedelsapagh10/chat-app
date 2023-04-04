import 'package:chat_app/Modules/controller/HomeCubit/HomCubit.dart';
import 'package:chat_app/Modules/controller/HomeCubit/HomeState.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///
  TextEditingController messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  void _scrollToLastMessage() {
    //_scrollController.position.minScrollExtent
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    // return StreamBuilder<QuerySnapshot>(

    //     ///get all messages  .orderBy(KCreatedAt)  to order them
    //     ///and by snapshot we can access all messages
    //     builder: ((context, snapshot) {
    //   if (snapshot.hasData) {
    //     ///
    //     ///
    //     //data that return from snapShot is map >>
    //     //and my list from type MessageModel
    //     //so i need to convert json to MessageModel
    //     ///
    List<MessageModel> MessageList = [];
    //     for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //       MessageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
    //     }
    //     //  print(snapshot.data!.docs[1]['message']); //message >>attribute name
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            appName,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Pacifico', fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: ((context, state) {
                  if (state is SucessHomeState) {
                    MessageList = state.messages;
                  }
                }),
                builder: (context, state) {
                  return ListView.builder(

                      ///
                      ///
                      ///
                      reverse: true,
                      controller: _scrollController,
                      itemCount: MessageList.length,
                      itemBuilder: (context, index) {
                        return MessageList[index].id == email
                            ? ChatBuble(
                                messageModel: MessageList[index],
                              )
                            : ChatBubleForFriend(
                                messageModel: MessageList[index],
                              );
                      });
                },
              ),
            ),
            Container(
              //  color: Color.fromARGB(31, 10, 10, 10),
              child: My_Text_Field(
                onTap: () {
                  BlocProvider.of<HomeCubit>(context)
                      .sendMessage(data: messageController.text, email: email);
                  messageController.clear();
                  _scrollToLastMessage();
                },
                controller: messageController,
                hintText: 'typing..',
                textInputType: TextInputType.text,
                onChange: ((value) {}),
                onFieldSubmitted: (data) {
                  BlocProvider.of<HomeCubit>(context)
                      .sendMessage(data: data, email: email);
                  messageController.clear();
                  _scrollToLastMessage();
                },
              ),
            )
          ],
        )
        // body: const Center(child: Text('you are login!')),
        );
  }
}
