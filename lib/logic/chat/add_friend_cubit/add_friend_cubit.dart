
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:meta/meta.dart';
import '../../../data/model/add_friend_model.dart';
part 'add_friend_state.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(AddFriendInitial());
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future<void> buildAddFriendCard() async {
    emit(AddFriendLoading());
    try {
      usersCollection.snapshots().listen((event) {
        List<AddFriendModel> addFriendList = [];
        for (var doc in event.docs) {
          if (doc['isFriend'] == false) {
            addFriendList.add(AddFriendModel.fromJson(doc));
          }
        }
        emit(AddFriendSuccess(data: addFriendList));
      });
    } on FirebaseFirestore catch (err) {
      emit(AddFriendFailure(message: err.toString()));
    } catch (err) {
      emit(AddFriendFailure(message: err.toString()));
    }
  }

  Future<void> addFriend(dynamic user) async {
    await FirebaseService.friendRequest(user);
  }
}
