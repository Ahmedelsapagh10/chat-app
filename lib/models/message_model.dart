import 'package:chat_app/constants.dart';

class MessageModel {
  final String message;
  final String id;

  ///
  ///
  MessageModel(this.message, this.id);
  //need parameter
  factory MessageModel.fromJson(json) {
    return MessageModel(
        json[KMessage], json['id']); //so ,here i give it   json('message')
  }
}
