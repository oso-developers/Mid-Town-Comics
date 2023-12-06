
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class MyPreOrder extends StatefulWidget {
  const MyPreOrder({super.key});

  @override
  State<MyPreOrder> createState() => _MyPreOrderState();
}

class _MyPreOrderState extends State<MyPreOrder> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size(size.width*1,allsize*0.11),
          child: Header_Widget(
            ontap: () => scaffoldKey.currentState!.openDrawer(),
            searchcontroller:searchController,
          ),),
        key: scaffoldKey,
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchList(searchcontroller: searchController),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Pre-Order Item",
                  style: TextStyle(
                      fontSize: allsize * 0.02,
                      fontWeight: FontWeight.bold),
                )),
            //Pending Item
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pending Items",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.016,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Table(
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: Text("Order",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Order#",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Total",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("QTY",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Rele",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Price",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                              ])
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Processed Item",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.016,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Table(
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: Text("Order",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("DateOrder",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Total",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("#Title",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("QTY",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Release",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Date",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Price",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Each",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                              ])
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cancelled Item",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.016,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Table(
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: Text("Order",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("DateOrder",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Total",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("#Title",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("QTY",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Release",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Date",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Price",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                                TableCell(
                                    child: Text("Each",
                                        style: TextStyle(
                                            fontSize: allsize * 0.011))),
                              ])
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const SubcribeWidget(),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Footer(),
            SizedBox(
              height: size.height * 0.015,
            )
          ],
        )),
      ),
    );
  }
}
