import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tada_local_storage/models/message.dart';

class MessageContainer extends StatelessWidget {
  final Message message;
  final bool myMessage;

  MessageContainer({Key? key, required this.message, required this.myMessage})
      : super(key: key);
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime messageCreated = message.created;
    String dateString =
        DateFormat(DateFormat.HOUR24_MINUTE).format(messageCreated);
    if (messageCreated.day != now.day)
      dateString = DateFormat(DateFormat.MONTH_DAY).format(messageCreated) +
          ', ' +
          dateString;
    if (messageCreated.year != now.year)
      dateString =
          DateFormat(DateFormat.YEAR).format(messageCreated) + ' ' + dateString;
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: (MediaQuery.of(context).size.width / 3) * 2),
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        child: Align(
          alignment: (myMessage ? Alignment.topRight : Alignment.topLeft),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (myMessage ? Colors.lightGreen : Colors.blueGrey),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment:
                  myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    message.text,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Text(dateString),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
