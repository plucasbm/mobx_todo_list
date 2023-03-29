import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  _TaskStore(this.title);

  final String title;

  @observable
  bool isDone = false;

  @action
  void toggleDone() => isDone = !isDone;
}