import 'package:chat_app/models/message_model.dart';

abstract class HomeState {}

class InitState extends HomeState {}

class SendState extends HomeState {}

class SucessHomeState extends HomeState {
  List<MessageModel> messages;
  SucessHomeState({
    required this.messages,
  });
}
