import 'package:floor/floor.dart';

@Entity(tableName: 'todo_items')
class TodoItem {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(name: 'text', nullable: false)
  String text;

  @ColumnInfo(name: 'update_date', nullable: false)
  String updateDate;

  @ColumnInfo(name: 'is_done', nullable: false)
  bool isDone;

  TodoItem(this.id, this.text, this.updateDate, this.isDone);


  @override
  String toString() {
    return 'TodoItem{id: $id, text: $text, updateDate: $updateDate, isDone: $isDone}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          updateDate == other.updateDate &&
          isDone == other.isDone;

  @override
  int get hashCode =>
      id.hashCode ^ text.hashCode ^ updateDate.hashCode ^ isDone.hashCode;
}
