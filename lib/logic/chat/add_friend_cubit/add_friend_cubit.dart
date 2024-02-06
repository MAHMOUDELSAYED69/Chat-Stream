import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../data/model/chat_card_model.dart';
part 'add_friend_state.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(AddFriendInitial());
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future<void> buildAddFriendCard() async {
    emit(AddFriendLoading());
    try {
      usersCollection.snapshots().listen((event) {
        List<ChatCardModel> chatCardList = [];
        for (var doc in event.docs) {
          chatCardList.add(ChatCardModel.fromJson(doc));
        }
        emit(AddFriendSuccess(data: chatCardList));
      });
    } on FirebaseFirestore catch (err) {
      emit(AddFriendFailure(message: err.toString()));
    } catch (err) {
      emit(AddFriendFailure(message: err.toString()));
    }
  }
}
