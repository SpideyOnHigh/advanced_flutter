import 'dart:async';

import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //shared variables and functions that will be used through any view model

  //stream controller for flowstate
  //so view model can tell view to load the particular state
  StreamController _streamController = StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    //closing the stream
    _streamController.close();
  }

  @override
  //init sink
  Sink get inputState => _streamController.sink;

  @override
  //init stream
  Stream<FlowState> get outputState =>
      _streamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start(); //will be called while init of view model
  void dispose(); //will be called when viewmodel dies

  //input state
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  //get output state
  Stream<FlowState> get outputState;
}
