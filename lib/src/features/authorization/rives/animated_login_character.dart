import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

final class AnimatedLoginCharacter {
  Artboard? artBoard;
  StateMachineController? _controller;
  SMITrigger? _failTrigger, _successTrigger;
  SMIBool? _isChecking, _isHandsUp;
  SMINumber? _lookingNum;

  Future<void> loadLoginArt() async {
    await RiveFile.initialize();

    final fileInAssets = await rootBundle.load('assets/rive/animated_login_character.riv');

    final file = RiveFile.import(fileInAssets);

    final artBoard = file.mainArtboard;

    // for getting login machine check out the rive animation in editor where you downloaded it
    // then check event that was created there (shortly, you can find name animation from editor)
    _controller = StateMachineController.fromArtboard(artBoard, 'Login Machine');

    if (_controller != null) {
      artBoard.addController(_controller!);
      for (var action in _controller!.inputs) {
        if (action.name == 'isChecking') {
          _isChecking = action as SMIBool;
        } else if (action.name == 'isHandsUp') {
          _isHandsUp = action as SMIBool;
        } else if (action.name == 'trigSuccess') {
          _successTrigger = action as SMITrigger;
        } else if (action.name == 'trigFail') {
          _failTrigger = action as SMITrigger;
        } else if (action.name == 'numLook') {
          _lookingNum = action as SMINumber;
        }
      }
    }

    this.artBoard = artBoard;
  }

  void handsUp(bool value) {
    _isHandsUp?.change(value);
    _isChecking?.change(false);
  }

  void dispose() => _controller?.dispose();
}
