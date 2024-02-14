part of 'add_friend_cubit.dart';

@immutable
abstract class AddFriendState {}

class AddFriendInitial extends AddFriendState {}

class AddFriendLoading extends AddFriendState {}

class AddFriendSuccess extends AddFriendState {
  final List<AddFriendModel> data;

  AddFriendSuccess({required this.data});
}

class AddFriendFailure extends AddFriendState {
  final String message;

  AddFriendFailure({required this.message});
}
