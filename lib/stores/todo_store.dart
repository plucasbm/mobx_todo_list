import 'package:mobx/mobx.dart';
import 'package:mobx_todo/stores/task_store.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  
  @observable
  String newTodoTitle = "";

  final todoList = ObservableList<TaskStore>();

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @action
  void addTodo() {
    todoList.insert(0, TaskStore(newTodoTitle));
    newTodoTitle = "";
  }

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;
}