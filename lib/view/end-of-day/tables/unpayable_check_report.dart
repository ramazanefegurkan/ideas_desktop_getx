import 'package:flutter/material.dart';
import 'package:ideas_desktop/extension/string_extension.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../model/end_of_day_unpayable_report_model.dart';
import '../../_utility/service_helper.dart';

class UnpayableCheckReportTable extends StatelessWidget {
  final UnpayableCheckReportDataSource source;
  final double totalAmount;
  const UnpayableCheckReportTable(
      {super.key, required this.source, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      shrinkWrapRows: true,
      allowSorting: true,
      footerFrozenRowsCount: 1,
      footer: Center(
          child: Text(
        'Toplam Tutar: ${totalAmount.getPriceString}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
      columns: [
        GridColumn(
          columnName: 'id',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Id',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(20),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Hesap Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'checkAmount',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Tutar',
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ],
    );
  }
}

class UnpayableCheckReportDataSource extends DataGridSource with ServiceHelper {
  UnpayableCheckReportDataSource(
      {required List<EndOfDayUnpayableCheckModel> checks}) {
    dataGridRows = checks
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.checkId),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<double>(
                  columnName: 'checkAmount', value: dataGridRow.checkAmount),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ));
      }).toList(),
    );
  }
}
