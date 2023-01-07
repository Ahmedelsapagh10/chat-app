import 'package:chat_app/Modules/controller/HomeCubit/HomeState.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitState());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  sendMessage({required String data, required String email}) {
    messages.add({KMessage: data, KCreatedAt: DateTime.now(), 'id': email});
  }

  getAllMessages() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      List<MessageModel> AllMessages = [];
      for (var doc in event.docs) {
        AllMessages.add(MessageModel.fromJson(doc));
      }
      emit(SucessHomeState(messages: AllMessages));
    });
  }
}
