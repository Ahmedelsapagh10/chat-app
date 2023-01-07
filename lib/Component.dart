import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class Custom_Text_Field extends StatelessWidget {
  String? hintText;
  bool? obscureText;
  TextInputType? textInputType;
  Function(String)? onChange;
  Function(String)? onFieldSubmitted;

  Custom_Text_Field(
      {this.hintText,
      this.textInputType,
      this.onChange,
      this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (e) {
        if (e!.isEmpty) {
          return 'Please Enter your info';
        }
      },
      //  onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
      obscureText: obscureText!,
      cursorColor: Colors.white,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.541)),
          focusColor: Colors.red,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.white60,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.white70,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.white70,
                width: 2,
              ))),
    );
  }
}

class MySpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({this.text, this.OnTap});

  String? text;
  VoidCallback? OnTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: OnTap,
      child: Container(
        child: Text(
          text!,
          style: TextStyle(
              color: KprimaryColor,
              //  fontFamily: 'Pacifico',
              fontSize: 18),
        ),
        height: 50,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 5),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

void ShowSnakBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
  ));
}

class ChatBuble extends StatelessWidget {
  ChatBuble({required this.messageModel});
  MessageModel messageModel; // element

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // symmetric(horizontal: 16, vertical: 8)
        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 16, left: 40),
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 16,
          right: 16,
        ),

        child: Text(
          messageModel.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        decoration: const BoxDecoration(
          color: KprimaryColor2,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18),
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
      ),
    );
  }
}

class My_Text_Field extends StatelessWidget {
  String? hintText;
  TextInputType? textInputType;
  Function(String)? onChange;
  Function(String)? onFieldSubmitted;
  VoidCallback onTap;
  TextEditingController? controller;
  My_Text_Field(
      {this.hintText,
      this.textInputType,
      required this.onTap,
      this.onChange,
      this.onFieldSubmitted,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        validator: (e) {
          if (e!.isEmpty) {
            return 'Please Enter your info';
          }
        },
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChange,
        cursorColor: Colors.grey,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: () {
                  onFieldSubmitted;
                },
                child: InkWell(
                  child: Icon(Icons.send, color: KprimaryColor),
                  onTap: onTap,
                )),
            hintText: hintText,
            hintStyle: TextStyle(color: KprimaryColor),
            focusColor: Colors.red,
            fillColor: Colors.grey,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 2,
                  color: KprimaryColor,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 2,
                  color: KprimaryColor,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: KprimaryColor,
                  width: 2,
                ))),
      ),
    );
  }
}

///
class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({required this.messageModel});
  MessageModel messageModel; // element

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // symmetric(horizontal: 16, vertical: 8)
        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 40, left: 16),
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 16,
          right: 16,
        ),

        child: Text(
          messageModel.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        decoration: const BoxDecoration(
          color: KprimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(18),
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
      ),
    );
  }
}
