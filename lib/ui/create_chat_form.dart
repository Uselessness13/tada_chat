import 'package:flutter/material.dart';

class CreateNewChatForm extends StatelessWidget {
  final void Function(String text) onSendButtonPressed;

  CreateNewChatForm({
    Key? key,
    required this.onSendButtonPressed,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.25),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create new chat',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Enter chat name...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      onSendButtonPressed(controller.text);
                    }
                  },
                  child: Text(
                    'CREATE',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
