import 'package:flutter/material.dart';
import 'package:notes/dao/dao_factory.dart';
import 'package:notes/dao/todo_item_dao.dart';
import 'package:notes/entity/todo_item.dart';

class TodoItemService extends ChangeNotifier {
  Future<List<TodoItem>> findAllTodoItemsOrderByUpdateDate() async {
    DaoFactory daoFactory = await DaoFactory.getInstance();
    TodoItemDao todoItemDao = daoFactory.todoItemDao;
    return todoItemDao.findAllTodoItemsOrderByUpdateDate();
  }

  Future<void> insertTodoItem(TodoItem todoItem) async {
    RegExp regex = RegExp(r'\n*');
    if (todoItem.text.isNotEmpty && regex.stringMatch(todoItem.text).isEmpty) {
      DaoFactory daoFactory = await DaoFactory.getInstance();
      TodoItemDao todoItemDao = daoFactory.todoItemDao;
      if (todoItem.id == null) {
        todoItemDao.insertTodoItem(todoItem);
      } else {
        updateTodoItem(todoItem);
      }
      notifyListeners();
    } else if (todoItem.id != null) {
      delete(todoItem.id);
    }
  }

  Future<void> updateTodoItem(TodoItem todoItem) async {
    RegExp regex = RegExp(r'\n*');
    if (todoItem.text.isNotEmpty && regex.stringMatch(todoItem.text).isEmpty) {
      DaoFactory daoFactory = await DaoFactory.getInstance();
      TodoItemDao todoItemDao = daoFactory.todoItemDao;
      todoItemDao.updateTodoItem(todoItem);
      notifyListeners();
    } else {
      delete(todoItem.id);
    }
  }

  Future<void> delete(int id) async {
    DaoFactory daoFactory = await DaoFactory.getInstance();
    TodoItemDao todoItemDao = daoFactory.todoItemDao;
    todoItemDao.deleteTodoItem(id);
    notifyListeners();
  }
}
