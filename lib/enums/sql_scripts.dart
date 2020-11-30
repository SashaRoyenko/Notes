class SqlScripts {
  static const String SELECT_NOTES_ORDER_BY_UPDATE_DATE = "SELECT * FROM notes ORDER BY update_date DESC";
  static const String DELETE_NOTE_BY_ID = "DELETE FROM notes WHERE id = :id";

  static const String SELECT_TODO_ITEMS_ORDER_BY_UPDATE_DATE = "SELECT * FROM todo_items ORDER BY is_done, update_date";
  static const String DELETE_TODO_ITEM_BY_ID = "DELETE FROM todo_items WHERE id = :id";
  SqlScripts._();
}