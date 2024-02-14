part of 'chat_card_cubit.dart';

@immutable
abstract class ChatCardState {}

class ChatCardInitial extends ChatCardState {}

class ChatCardLoading extends ChatCardState {}

class ChatCardSuccess extends ChatCardState {
  final List<ChatCardModel> data;

  ChatCardSuccess({required this.data});
}

class ChatCardFailure extends ChatCardState {
  final String message;

  ChatCardFailure({required this.message});
}
