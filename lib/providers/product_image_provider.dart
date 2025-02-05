// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageSelectionNotifier extends StateNotifier<List<File>>{
//   final ImagePicker picker = ImagePicker();

//   ImageSelectionNotifier(): super([]);
//   Future<void> pickImages() async{
//     final List<XFile> pickedFiles = await picker.pickMultiImage();
//     if(pickedFiles.length + state.length > 3) {
//       state = pickedFiles.take(3).map((file)=> File(file.path)).toList();
//     }else{
//       state = [...state, ...pickedFiles.take(3 - state.length).map((file)=>File(file.path))];
//     }
//     }
//   void removeImage(int index){
//     state = List.from(state)..removeAt(index);
//   }
// }

// final imageSelectionProvider = StateNotifierProvider<ImageSelectionNotifier, List<File>>((ref)=> ImageSelectionNotifier(),);

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageSelectionNotifier extends StateNotifier<List<File>> {
  final ImagePicker picker = ImagePicker();

  ImageSelectionNotifier() : super([]);

  /// Pick images from gallery
  Future<void> pickImages() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      final List<File> selectedImages =
          pickedFiles.map((file) => File(file.path)).toList();

      if (selectedImages.length + state.length > 3) {
        state = selectedImages.take(3).toList();
      } else {
        state = [...state, ...selectedImages.take(3 - state.length)];
      }
    }
  }

  /// Remove selected image
  void removeImage(int index) {
    state = List.from(state)..removeAt(index);
  }

  /// Upload images to Firebase Storage & get URLs
  Future<List<String>> uploadImages() async {
    List<String> downloadUrls = [];
    for (File image in state) {
      String fileName = image.path.split('/').last;
      Reference ref =
          FirebaseStorage.instance.ref().child('product_images/$fileName');

      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(imageUrl);
    }
    return downloadUrls;
  }
}

/// Provider for image selection
final imageSelectionProvider =
    StateNotifierProvider<ImageSelectionNotifier, List<File>>(
  (ref) => ImageSelectionNotifier(),
);
