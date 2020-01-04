import 'package:flutter/material.dart';





class TestTable extends StatefulWidget {
  TestTable({Key key}) : super(key: key);

  @override
  _TestTableState createState() => _TestTableState();
}

class _TestTableState extends State<TestTable> {

  Widget bodyData(){
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: const Text('loan amount'),
          numeric: true
        ),
        DataColumn(
          label: const Text('duration'),
          numeric: true
        ),
        DataColumn(
          label: const Text('intrest'),
          numeric: true
        )
      ],
      rows: <DataRow>[],
    );

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: bodyData(),
    );
  }
}

