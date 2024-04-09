import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class DataTableDynamic extends StatelessWidget {
  final List<String> headersRows;
  final Iterable<TableRow> data;
  final VoidCallback getNextData;
  final VoidCallback getPreviousData;
  final int page;
  final int totalPage;

  const DataTableDynamic({
    super.key,
    required this.headersRows,
    required this.data,
    required this.getNextData,
    required this.getPreviousData,
    required this.page,
    required this.totalPage,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (data.isNotEmpty &&
        headersRows.isNotEmpty &&
        data.first.children.length == headersRows.length) {
      return Container(
        margin: const EdgeInsets.only(bottom: 15, top: 5),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
              width: size.width,
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FixedColumnWidth(150),
                  2: FixedColumnWidth(150),
                  3: FixedColumnWidth(100),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.5))),
                    children: <Widget>[
                      ...headersRows.sublist(0, 1).map(
                            (value) => TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 40,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                      ...headersRows.sublist(1).map(
                            (value) => TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: 4, bottom: 10, left: 40, right: 40),
                width: size.width,
                height: size.height * (isTablet(context) ? 0.7 : 0.45),
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FixedColumnWidth(150),
                      2: FixedColumnWidth(150),
                      3: FixedColumnWidth(100),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [...data],
                  ),
                )),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: page <= 1 ? null : getPreviousData,
                      icon: const Icon(Icons.arrow_back)),
                  Text('$page - $totalPage'),
                  IconButton(
                      onPressed: page >= totalPage ? null : getNextData,
                      icon: const Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
