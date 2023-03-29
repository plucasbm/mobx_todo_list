import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_todo/stores/todo_store.dart';
import 'package:mobx_todo/widgets/custom_icon_button.dart';
import 'package:mobx_todo/widgets/custom_text_field.dart';

import 'login_page.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final todoStore = TodoStore();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Observer(
                          builder: (_) {
                            return CustomTextField(
                              controller: controller,
                              hint: 'Tarefa',
                              onChanged: todoStore.setNewTodoTitle,
                              suffix: CustomIconButton(
                                radius: 32,
                                iconData: todoStore.isFormValid ? Icons.add : Icons.warning,
                                onTap: (){
                                  todoStore.addTodo();
                                  controller.clear();
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Observer(
                            builder: (_){
                              return ListView.separated(
                                itemCount: todoStore.todoList.length,
                                itemBuilder: (_, index) {
                                  return Observer(
                                    builder: (_){
                                      return ListTile(
                                        title: Text(
                                          todoStore.todoList[index].title,
                                          style: TextStyle(
                                            decoration: todoStore.todoList[index].isDone 
                                              ? TextDecoration.lineThrough
                                              : null,
                                            color: todoStore.todoList[index].isDone 
                                            ? Colors.grey
                                            : Colors.black,
                                          ),
                                        ),
                                        onTap: todoStore.todoList[index].toggleDone,
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (_, __) {
                                  return const Divider();
                                },
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
