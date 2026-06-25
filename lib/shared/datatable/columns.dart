import 'package:data_table_2/data_table_2.dart';

class TableColumnModel {
  final String title;
  final ColumnSize size;

  const TableColumnModel({required this.title, this.size = ColumnSize.S});
}
