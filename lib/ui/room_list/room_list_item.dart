import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tada_models/tada_models.dart';

class RoomListItem extends StatelessWidget {
  final Room room;
  RoomListItem({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  room.name.substring(0, 2).toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      title: Text(room.name),
      subtitle: Row(children: [
        Text(
          '${room.lastMessage?.sender?.username ?? ''}: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            room.lastMessage?.text ?? '',
            style: TextStyle(fontWeight: FontWeight.normal),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          DateFormat(DateFormat.HOUR24_MINUTE)
              .format(room.lastMessage!.created ?? DateTime.now()),
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
        )
      ]),
    );
  }
}
