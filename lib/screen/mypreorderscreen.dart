
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class MyPreOrderScreen extends StatefulWidget {
  const MyPreOrderScreen({super.key});

  @override
  State<MyPreOrderScreen> createState() => _MyPreOrderScreenState();
}

class _MyPreOrderScreenState extends State<MyPreOrderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
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
                "My Pre-Orders",
                style: TextStyle(
                    fontSize: allsize * 0.02, fontWeight: FontWeight.bold),
              ),
            ),
            //Order In Process
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
                          "Approved Data",
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
                            children:  [
                              TableRow(children: [
                                TableCell(child: Text("Date",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Order#",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Total",style: TextStyle(fontSize: allsize*0.011)))
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
            //Order Process
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
                          "Shipped Order",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize:  allsize*0.016,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Table(
                            children:  [
                              TableRow(children: [
                                TableCell(child: Text("Date",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Order#",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Total",style: TextStyle(fontSize: allsize*0.011))),
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
            //Order Declined
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
                          "Pending Order",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize*0.016,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Table(
                            children:  [
                              TableRow(children: [
                                TableCell(child: Text("Date",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Order#",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Total",style: TextStyle(fontSize: allsize*0.011))),
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
            //Order Cancelled
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
                          "Cancelled Order",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize:  allsize*0.016,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Table(
                            children:  [
                              TableRow(children: [
                                TableCell(child: Text("Date",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Order#",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Total",style: TextStyle(fontSize: allsize*0.011))),
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
            //Arcieve Orders
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
                          "Declined Order",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize*0.016,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Table(
                            children:   [
                              TableRow(children: [
                                TableCell(child: Text("Date",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Order#",style: TextStyle(fontSize: allsize*0.011))),
                                TableCell(child: Text("Total",style: TextStyle(fontSize: allsize*0.011))),
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
            SizedBox(height: size.height*0.02,),
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
