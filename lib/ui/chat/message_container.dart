import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tada_models/tada_models.dart';

class MessageContainer extends StatelessWidget {
  final ServerMessage message;
  final bool myMessage;

  MessageContainer({Key? key, required this.message, required this.myMessage})
      : super(key: key);
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime messageCreated = message.created ?? DateTime.now();
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
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text ?? '',
                  style: TextStyle(fontSize: 15),
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
