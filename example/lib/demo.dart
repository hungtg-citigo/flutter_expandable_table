import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';


/*
* input
* {"header_group_key":<Data>[]} //Dữ liệu thô đầu vào
* header_title_key => để xác định vị trí cột trong row
* {"header_title_key" : "Tên cột"} // Dữ liệu để hiển thị tên cột
* {"header_title_key" : RowData} // Dữ liệu để hiển thị các giá trị row
* RowData = {header_title_key - isLegend - Data}
* */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SyncScrollListView(),
    );
}

class SyncScrollListView extends StatefulWidget {
  @override
  _SyncScrollListViewState createState() => _SyncScrollListViewState();
}

class _SyncScrollListViewState extends State<SyncScrollListView> {
  final ScrollController _scrollController = ScrollController();
  late LinkedScrollControllerGroup verticalScrollController;
  late ScrollController scrollA;
  late ScrollController scrollB;


  @override
  void initState() {
    super.initState();
    verticalScrollController = LinkedScrollControllerGroup();
    scrollA = verticalScrollController.addAndGet();
    scrollB = verticalScrollController.addAndGet();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Sync Scroll ListView")),
      body: Row(
        children: [
          Container(
            width: 150,
            child: ListView.builder(
              controller: scrollA, // Cùng 1 controller
              itemCount: 30,
              itemBuilder: (context, index) => ListTile(
                title: Text('List A - Item $index'),
              ),
            ),

          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1000,
                child: ListView.builder(
                  controller: scrollB, // Cùng 1 controller
                  itemCount: 30,
                  itemBuilder: (context, index) => ListTile(
                    title: Text('List B - Item $index | List B - Item $index | List B - Item $index | List B - Item $index | List B - Item $index'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
}
