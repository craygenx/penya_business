import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiTextControllerNotifier extends StateNotifier<Map<String, TextEditingController>>{
  MultiTextControllerNotifier():super({});
  void initController(String key){
    if(!state.containsKey(key)){
      state = {...state, key: TextEditingController()};
    }
  }
  TextEditingController getController(String key){
    return state[key]!;
  }
  void updateText(String key, String text){
    if(!state.containsKey(key)){
      state[key]!.text = text;
    }
  }
  @override
  void dispose() {
    for (var controller in state.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
final multiTextControllerProvider = StateNotifierProvider<MultiTextControllerNotifier, Map<String, TextEditingController>>((ref) => MultiTextControllerNotifier());