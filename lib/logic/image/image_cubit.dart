import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../core/cache/cache_functions.dart';
part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  File? selectedImage;
  Future<void> pickImageFromGallery() async {
    emit(Imageloading());
    try {
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      // selectedImage = File(returnImage!.path);
      if (returnImage != null) {
        await FirebaseAuthService.updateUserImage(urlImage: returnImage.path);
        CacheData.setData(key: "uploadImage", value: returnImage.path);
        emit(ImageSuccess(imageUrl: returnImage.path));
      }
    } on Exception catch (err) {
      emit(ImageFailure(message: err.toString()));
    }
  }
}
