import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_card_state.dart';

class ChatCardCubit extends Cubit<ChatCardState> {
  ChatCardCubit() : super(ChatCardInitial());
  Future<void> buildChatCard() async {
    emit(ChatCardLoading());
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      final QuerySnapshot querySnapshot = await usersCollection.get();
    } on FirebaseFirestore catch (err) {
      emit(ChatCardFailure(message: err.toString()));
    } catch (err) {
      emit(ChatCardFailure(message: err.toString()));
    }
  }
}
