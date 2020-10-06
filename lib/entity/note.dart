import 'package:floor/floor.dart';

@Entity(tableName: 'notes')
class Note {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(name: 'text', nullable: false)
  String text;

  @ColumnInfo(name: 'json_formatted_text', nullable: false)
  String jsonFormattedText;

  @ColumnInfo(name: 'update_date', nullable: false)
  String updateDate;

  Note(this.id, this.text, this.jsonFormattedText, this.updateDate);


  @override
  String toString() {
    return 'Note{id: $id, text: $text, jsonFormattedText: $jsonFormattedText, updateDate: $updateDate}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          jsonFormattedText == other.jsonFormattedText &&
          updateDate == other.updateDate;

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      jsonFormattedText.hashCode ^
      updateDate.hashCode;
}
