import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionNotifier extends StateNotifier<List<File>>{
  final ImagePicker picker = ImagePicker();

  ImageSelectionNotifier(): super([]);
  Future<void> pickImages() async{
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if(pickedFiles.length + state.length > 3) {
      state = pickedFiles.take(3).map((file)=> File(file.path)).toList();
    }else{
      state = [...state, ...pickedFiles.take(3 - state.length).map((file)=>File(file.path))];
    }
    }
  void removeImage(int index){
    state = List.from(state)..removeAt(index);
  }
}

final imageSelectionProvider = StateNotifierProvider<ImageSelectionNotifier, List<File>>((ref)=> ImageSelectionNotifier(),);