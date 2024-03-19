import 'package:flutter/material.dart';

class DataTableDynamic extends StatelessWidget {
  final List<String> headersRows;
  final Iterable<DataRow> data;

  const DataTableDynamic({
    super.key,
    required this.headersRows,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (data.isNotEmpty &&
        headersRows.isNotEmpty &&
        data.first.cells.length == headersRows.length) {
      return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 15, top: 5),
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 60, left: 40, right: 40),
                width: size.width,
                child: DataTable(
                  columns: [
                    ...headersRows.map(
                      (value) => DataColumn(label: Text(value)),
                    ),
                  ],
                  rows: [
                    ...data,
                    const DataRow(cells: [
                      DataCell(SizedBox(
                        height: 250,
                      )),
                      DataCell(SizedBox(
                        height: 250,
                      )),
                      DataCell(SizedBox(
                        height: 250,
                      )),
                      DataCell(SizedBox(
                        height: 250,
                      )),
                    ]),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                    const Text('1 - 100'),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward)),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 300,
                    margin:
                        const EdgeInsets.only(right: 40, left: 40, bottom: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.clear)),
                          icon: const Icon(
                            Icons.search,
                          ),
                          hintText: 'Busqueda por nombre'),
                    ),
                  ),
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
