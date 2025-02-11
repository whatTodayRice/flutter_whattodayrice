import 'dart:async';

import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:injectable/injectable.dart';

// test 2
// test 3
@LazySingleton()
class EventBus {
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;
  EventBus._internal();

  final eventController = StreamController<dynamic>.broadcast();

  Stream<T> on<T>() => eventController.stream.where((event) => event is T).cast<T>();

  void fire<T>(T event) => eventController.add(event);

  void dispose() => eventController.close();
}

class PostCreatedEvent {
  final Post post;

  PostCreatedEvent(this.post);
}
