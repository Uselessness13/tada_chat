import 'package:flutter/material.dart';
import 'package:tada_models/tada_models.dart';

class MessageContainer extends StatelessWidget {
  final ServerMessage message;
  final bool myMessage;

  MessageContainer({Key? key, required this.message, required this.myMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (myMessage ? Alignment.topRight : Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (myMessage ? Colors.lightGreen : Colors.blueGrey),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message.text ?? '',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
