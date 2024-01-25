part of 'delete_account_cubit.dart';

@immutable
abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {}

class DeleteAccountFailure extends DeleteAccountState {
  final String message;

  DeleteAccountFailure({required this.message});
}
