part of 'rooms_cubit.dart';

@immutable
abstract class RoomsState {}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsError extends RoomsState {
  final String error;

  RoomsError(this.error);
}

class RoomsLoaded extends RoomsState {
  final List<Room> rooms;

  RoomsLoaded(this.rooms);
}
