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
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          width: double.infinity,
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                flex: 5,
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Введите сообщение...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: FloatingActionButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
