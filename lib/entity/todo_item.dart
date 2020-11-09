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

}
