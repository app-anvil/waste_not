// ignore_for_file: comment_references

import 'dart:async';

import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import '../../../storages_repository.dart';

abstract class StoragesRepository
    extends CrudRepository<StorageEntity, StoragesRepositoryState> {
  static StoragesRepository get I => GetIt.I.get<StoragesRepository>();

  //List<StorageEntity> get storages;

  Future<void> add({
    required String name,
    required StorageType type,
    String? description,
  });

  Future<StorageEntity> update({
    required String id,
    required String name,
    required StorageType type,
    required double orderingPriority,
    String? description,
  });

  Future<void> reorder({required int oldIndex, required int newIndex});

  Future<void> fetch();

  /// Deletes a [StorageEntity] by its [id].
  ///
  /// Returns whether the storage has been successfully deleted.
  Future<bool> delete(String id);
}

// TODO(calbi): move inside common component
abstract class CrudRepository<O, State> with LoggerMixin, Observable<State> {
  // TODO(calbi): we can add the crud operations;

  List<O> get items;

  O getItemOrThrow(String id);
}

/// State class to be used with [Observable].
class ObservableEvent<State> extends Equatable {
  const ObservableEvent(this.previousState, this.state);
  final State? previousState;
  final State state;

  @override
  List<Object?> get props => [previousState, state];
}

mixin Observable<State> on LoggerMixin {
  BehaviorSubject<ObservableEvent<State>>? _subject;

  /// The initial state of the instance.
  ///
  /// Cannot be null.
  @protected
  State get initialState;

  /// The current state of the instance.
  State get state => subject.value.state;

  /// The previous state of the instance.
  ///
  /// When the instance is first created, this value is null.
  State? get previousState => subject.value.previousState;

  /// Whether the [stream] is closed.
  ///
  /// If true the stream cannot be listened to and the [emit] function must
  /// not be called.
  @nonVirtual
  bool get isClosed => subject.isClosed;

  /// This getter exposes the subject as a stream.
  ///
  /// Try to use this over listen method.
  Stream<ObservableEvent<State>> get states {
    _initSubject();
    return _subject!.asBroadcastStream();
  }

  /// Exposes a [BehaviorSubject].
  ///
  /// The difference between listen to [stream] and [subject] is that
  ///
  /// > Subject is a special StreamController that captures the latest item
  /// > that has been added to the controller, and emits that as the first
  /// > item to any new listener.
  ///
  /// Ref: [BehaviorSubject](https://pub.dev/documentation/rxdart/latest/rx/BehaviorSubject-class.html)
  @nonVirtual
  @protected
  BehaviorSubject<ObservableEvent<State>> get subject {
    _initSubject();
    return _subject!;
  }

  ///  Initializes the [_subject] if it is not already initialized.
  void _initSubject() {
    if (_subject != null) return;
    _subject = BehaviorSubject.seeded(
      ObservableEvent(null, initialState),
    );
  }

  /// We use the stream of subject. In this way the last event is not forward.
  /// It similar to a simple stream, or a publishSubject.
  @nonVirtual
  StreamSubscription<ObservableEvent<State>> listen(
    void Function(State? previousState, State state) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      subject.stream.listen(
        (value) => onData(value.previousState, value.state),
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  /// Emits a new [newState] to the [stream].
  ///
  ///
  /// This method should not be called after [close] is called.
  @protected
  @nonVirtual
  void emit(State newState) {
    if (isClosed) {
      throw StateError('Cannot emit new states after calling close');
    }

    final previousState = state;
    final newEvent = ObservableEvent(previousState, newState);
    subject.add(newEvent);
    logger.v('$runtimeType: $previousState ==> $newState');
  }

  /// Closes the instance.
  ///
  /// This method should be called when the instance is no longer needed.
  /// Once [close] is called, the instance can no longer be used.
  @mustCallSuper
  @protected
  Future<void> close() async {
    await subject.close();
  }
}
