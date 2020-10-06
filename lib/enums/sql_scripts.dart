class SqlScripts {
  static const String CREATE_DATABASE = "";
  static const String SELECT_NOTES_ORDER_BY_UPDATE_DATE = "SELECT * FROM notes ORDER BY update_date DESC";
  static const String DELETE_NOTE_BY_ID = "DELETE FROM notes WHERE id = :id";

  SqlScripts._();
}