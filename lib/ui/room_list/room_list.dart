import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_chat/cubit/rooms/rooms_cubit.dart';
import 'room_list_item.dart';

class RoomList extends StatelessWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomsCubit, RoomsState>(
      listener: (context, state) {
        if (state is RoomsError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is RoomsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RoomsError)
          return Center(
            child: Column(
              children: [
                Text('Произошла ошибка\n${state.error}'),
                TextButton(
                    onPressed: () => context.read<RoomsCubit>().loadRooms(),
                    child: Text('ПОВТОРИТЬ'))
              ],
            ),
          );
        else if (state is RoomsLoaded)
          return ListView.builder(
              itemCount: state.rooms.length,
              itemBuilder: (BuildContext context, int index) =>
                  RoomListItem(room: state.rooms[index]));
        return Container();
      },
    );
  }
}
