import 'package:floor/floor.dart';
import 'package:notes/entity/todo_item.dart';
import 'package:notes/enums/sql_scripts.dart';

@dao
abstract class TodoItemDao {
  @Query(SqlScripts.SELECT_TODO_ITEMS_ORDER_BY_UPDATE_DATE)
  Future<List<TodoItem>> findAllTodoItemsOrderByUpdateDate();

  @insert
  Future<void> insertTodoItem(TodoItem note);

  @update
  Future<void> updateTodoItem(TodoItem note);

  @Query(SqlScripts.DELETE_TODO_ITEM_BY_ID)
  Future<void> deleteTodoItem(int id);
}
