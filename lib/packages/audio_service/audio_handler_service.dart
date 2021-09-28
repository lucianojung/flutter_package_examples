import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class AudioHandlerService extends InheritedWidget {
  final AudioHandler audioHandler;

  const AudioHandlerService({
    required Key key,
    required this.audioHandler,
    required Widget child,
  })
      : assert(child != null),
        super(key: key, child: child);

  static AudioHandlerService of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AudioHandlerService>(
        ) as AudioHandlerService;
  }

  @override
  bool updateShouldNotify(AudioHandlerService old) {
    return audioHandler != old.audioHandler;
  }
}