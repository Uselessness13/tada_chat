import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_chat/cubit/cubit/chat_cubit.dart';
import 'package:tada_chat/ui/chat/chat_screen.dart';
import 'package:tada_local_storage/models/room.dart';

class RoomListItem extends StatelessWidget {
  final Room room;
  RoomListItem({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
          context.read<ChatCubit>().loadRoom(room.name);
          Navigator.of(context)
              .pushNamed(ChatScreen.routeName, arguments: room.name);
        },
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
        subtitle: room.message != null
            ? Row(children: [
                Text(
                  '${room.message!.sender.username}: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    room.message!.text,
                    style: TextStyle(fontWeight: FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  DateFormat(DateFormat.HOUR24_MINUTE)
                      .format(room.message!.created),
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal),
                )
              ])
            : Text('no messages yet'),
      ),
    );
  }
}
