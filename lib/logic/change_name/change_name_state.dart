part of 'change_name_cubit.dart';

@immutable
abstract class ChangeNameState {}

class ChangeNameInitial extends ChangeNameState {}

class ChangeNameLoading extends ChangeNameState {}

class ChangeNameSuccess extends ChangeNameState {}

class ChangeNameFailure extends ChangeNameState {
  final String message;

  ChangeNameFailure({required this.message});
}
