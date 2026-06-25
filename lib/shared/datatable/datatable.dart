import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ResponsiveDataTable extends StatelessWidget {
  final List<DataColumn2> columns;

  final List<DataRow> rows;

  final double minWidth;

  const ResponsiveDataTable({
    super.key,

    required this.columns,

    required this.rows,

    this.minWidth = 1000,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < minWidth;

        return Column(
          children: [
            if (isMobile)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),

                child: Row(
                  children: [
                    Icon(Icons.swipe, size: 16),

                    SizedBox(width: 6),

                    Text("Swipe horizontally to view all columns"),
                  ],
                ),
              ),

            Expanded(
              child: Scrollbar(
                thumbVisibility: true,

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: SizedBox(
                    width: isMobile ? minWidth : constraints.maxWidth,

                    child: DataTable2(
                      minWidth: minWidth,

                      border: TableBorder.all(color: Colors.grey.shade300),

                      headingRowHeight: 56,

                      dataRowHeight: 60,

                      horizontalMargin: 16,

                      columnSpacing: 20,

                      columns: columns,

                      rows: rows,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
