import 'package:rxdart/rxdart.dart';

//bottom-line up front: this class is a wrapper over BehaviorSubject

//an in-memory store backed by BehaviorSubject
//can be used to store data for all app repositories
class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  //the BehaviorSubject holding the data
  final BehaviorSubject<T> _subject;

  //the output stream that can be used to listen to the data
  Stream<T> get stream => _subject.stream;

  //synchronous getter for the current value
  T get value => _subject.value;
  //setter for updating the value
  set value(T value) => _subject.add(value);

  //remember to close this method when done
  void close() => _subject.close();
}
