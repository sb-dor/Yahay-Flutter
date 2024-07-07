import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'telegram_file_picker_events.dart';
import 'telegram_file_picker_state.dart';

@immutable
class TelegramFilePickerBloc {
  final Sink<TelegramFilePickerEvents> events;
  final BehaviorSubject<TelegramFilePickerStates> _states;

  BehaviorSubject<TelegramFilePickerStates> get states => _states;

  const TelegramFilePickerBloc._({
    required this.events,
    required BehaviorSubject<TelegramFilePickerStates> states,
  }) : _states = states;

  factory TelegramFilePickerBloc() {
    final events = BehaviorSubject<TelegramFilePickerEvents>();

    final streamOfEvents = events.switchMap((events) async* {
      yield* _streamHandler(events);
    }).startWith(TelegramFilePickerInitial());

    final behaviourSubjectFromStream = BehaviorSubject<TelegramFilePickerStates>()
      ..addStream(streamOfEvents);

    return TelegramFilePickerBloc._(
      events: events,
      states: behaviourSubjectFromStream,
    );
  }

  static Stream<TelegramFilePickerStates> _streamHandler(
    TelegramFilePickerEvents event,
  ) async* {}
}
