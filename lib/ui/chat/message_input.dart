import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final void Function(String text) onSendButtonPressed;
  final TextEditingController controller = TextEditingController();
  MessageInput({
    Key? key,
    required this.onSendButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Введите сообщение...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  onSendButtonPressed(controller.text.trim());
                  controller.text = '';
                }
              },
              child: Icon(
                Icons.send,
                color: Colors.black,
                size: 18,
              ),
              backgroundColor: Colors.white,
              elevation: 1,
            ),
          ],
        ),
      ),
    );
  }
}
