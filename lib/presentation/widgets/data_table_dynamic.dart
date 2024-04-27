import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
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
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            width: size.width,
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
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
            margin:
                const EdgeInsets.only(top: 4, bottom: 10, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [...data],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${S.current.Total_de_resultados} 100', //TODO: Cambiar cuando este listo el endpoint
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: page <= 1 ? null : getPreviousData,
                    icon: const Icon(Icons.arrow_back)),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '${S.current.Pagina}  ', //Dejar espacio en blanco
                        style: const TextStyle(
                          color: $colorTextBlack,
                        )),
                    TextSpan(
                        text: '$page',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: $colorTextBlack,
                          fontSize: 17,
                        )),
                    TextSpan(
                        text: '  ${S.current.De}  ', //Dejar espacio en blanco
                        style: const TextStyle(
                          color: $colorTextBlack,
                        )),
                    TextSpan(
                        text: '$totalPage',
                        style: const TextStyle(
                          color: $colorTextBlack,
                          fontSize: 17,
                        )),
                  ]),
                ),
                IconButton(
                    onPressed: page >= totalPage ? null : getNextData,
                    icon: const Icon(Icons.arrow_forward)),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
