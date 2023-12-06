import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/orderprovider.dart';
import 'package:midtowncomics/widget/searchList.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool active = true;
  bool inactive = false;
  TextEditingController searchcontroller=TextEditingController();
  Color getColor(Set<MaterialState> states) {
    return const Color(0xffececec);
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
            searchcontroller:searchcontroller,
          ),),
        key: scaffoldKey,
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(child:
            Consumer<OrderProvider>(builder: (context,order, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchList(searchcontroller: searchcontroller),
              Container(
                height: size.height*0.065,
                color: Colors.grey[200],
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "My Orders",
                    style: TextStyle(
                        fontSize: allsize * 0.02,
                        fontFamily: 'oswald_bold',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //Order In Process
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(allsize*0.003),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orders in Process",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.015,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: size.width*0.025),
                          child: Theme(
                            data: Theme.of(
                                context)
                                .copyWith(
                                dividerColor:
                                Colors
                                    .transparent),
                            child: SizedBox(
                              width: size.width*1,
                              child: DataTable(
                                headingRowColor:
                                MaterialStateProperty
                                    .resolveWith(
                                    getColor),
                                headingRowHeight:
                                size.height *
                                    0.025,
                                horizontalMargin:
                                0,
                                // columnSpacing:size.width*0.06,
                                // Add column spacing for better visibility
                                dataRowHeight:
                                size.height *
                                    0.025,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), // Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Order#',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                    order.inProcessOrder.length,
                                        (index) {
                                      final item =
                                      order.inProcessOrder[
                                      index];
                                      return DataRow(
                                        // color: index %
                                        //     2 ==
                                        //     0
                                        //     ? null
                                        //     : MaterialStateProperty
                                        //     .resolveWith(
                                        //     getColor),
                                        cells: [
                                          DataCell(
                                              StreamBuilder<Object>(
                                                  stream: null,
                                                  builder: (context, snapshot) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          item[
                                                          'od_stmp'],
                                                          style:
                                                          TextStyle(fontSize: allsize * 0.012),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              )),
                                          DataCell(
                                              Text(
                                                "${item['od_id']}",
                                                style: TextStyle(
                                                    color: const Color(0xff006ccf),
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                          DataCell(
                                              Text(
                                                "\$${item['total']}",
                                                style: TextStyle(
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Order Process
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(allsize*0.003),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orders Process / Shipped and Completed",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.015,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: size.width*0.025),
                          child: Theme(
                            data: Theme.of(
                                context)
                                .copyWith(
                                dividerColor:
                                Colors
                                    .transparent),
                            child: SizedBox(
                              width: size.width*1,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: DataTable(
                                  headingRowColor:
                                  MaterialStateProperty
                                      .resolveWith(
                                      getColor),
                                  headingRowHeight:
                                  size.height *
                                      0.032,
                                  horizontalMargin:
                                  0,
                                  // columnSpacing:size.width*0.06,
                                  // Add column spacing for better visibility
                                  dataRowHeight:
                                  size.height *
                                      0.032,
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Date',
                                        style: TextStyle(
                                            color: Colors.grey[
                                            700],
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            allsize *
                                                0.014), // Set text color for the heading
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Order#',
                                        style: TextStyle(
                                            color: Colors.grey[
                                            700],
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            allsize *
                                                0.014), //// Set text color for the heading
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Colors.grey[
                                            700],
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            allsize *
                                                0.014), //// Set text color for the heading
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Tracking',
                                        style: TextStyle(
                                            color: Colors.grey[
                                            700],
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            allsize *
                                                0.014), //// Set text color for the heading
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                      order.shippedOrder.length,
                                          (index) {
                                        final item =
                                        order.shippedOrder[
                                        index];
                                        return DataRow(
                                          // color: index %
                                          //     2 ==
                                          //     0
                                          //     ? null
                                          //     : MaterialStateProperty
                                          //     .resolveWith(
                                          //     getColor),
                                          cells: [
                                            DataCell(
                                                StreamBuilder<Object>(
                                                    stream: null,
                                                    builder: (context, snapshot) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            item[
                                                            'od_stmp'],
                                                            style:
                                                            TextStyle(fontSize: allsize * 0.014),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                )),
                                            DataCell(
                                                Text(
                                                  "${item['od_id']}",
                                                  style: TextStyle(
                                                      color: const Color(0xff006ccf),
                                                      fontSize:
                                                      allsize * 0.014),
                                                )),
                                            DataCell(
                                                Text(
                                                  "\$${item['total']}",
                                                  style: TextStyle(
                                                      fontSize:
                                                      allsize * 0.014),
                                                )),
                                            DataCell(
                                                Text(
                                                  item['od_track'],
                                                  style: TextStyle(
                                                      fontSize:
                                                      allsize * 0.014),
                                                )),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Order Declined
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(allsize*0.003),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orders Declined",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: allsize * 0.015,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: size.width*0.025),
                          child: Theme(
                            data: Theme.of(
                                context)
                                .copyWith(
                                dividerColor:
                                Colors
                                    .transparent),
                            child: SizedBox(
                              width: size.width*1,
                              child: DataTable(
                                headingRowColor:
                                MaterialStateProperty
                                    .resolveWith(
                                    getColor),
                                headingRowHeight:
                                size.height *
                                    0.025,
                                horizontalMargin:
                                0,
                                // columnSpacing:size.width*0.06,
                                // Add column spacing for better visibility
                                dataRowHeight:
                                size.height *
                                    0.025,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), // Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Order#',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                    order.declinedOrder.length,
                                        (index) {
                                      final item =
                                      order.declinedOrder[
                                      index];
                                      return DataRow(
                                        // color: index %
                                        //     2 ==
                                        //     0
                                        //     ? null
                                        //     : MaterialStateProperty
                                        //     .resolveWith(
                                        //     getColor),
                                        cells: [
                                          DataCell(
                                              StreamBuilder<Object>(
                                                  stream: null,
                                                  builder: (context, snapshot) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          item[
                                                          'od_stmp'],
                                                          style:
                                                          TextStyle(fontSize: allsize * 0.012),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              )),
                                          DataCell(
                                              Text(
                                                "${item['od_id']}",
                                                style: TextStyle(
                                                    color: const Color(0xff006ccf),
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                          DataCell(
                                              Text(
                                                "\$${item['total']}",
                                                style: TextStyle(
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Order Cancelled
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(allsize*0.003),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orders Cancelled",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.015,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: size.width*0.025),
                          child: Theme(
                            data: Theme.of(
                                context)
                                .copyWith(
                                dividerColor:
                                Colors
                                    .transparent),
                            child: SizedBox(
                              width: size.width*1,
                              child: DataTable(
                                headingRowColor:
                                MaterialStateProperty
                                    .resolveWith(
                                    getColor),
                                headingRowHeight:
                                size.height *
                                    0.025,
                                horizontalMargin:
                                0,
                                // columnSpacing:size.width*0.06,
                                // Add column spacing for better visibility
                                dataRowHeight:
                                size.height *
                                    0.025,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), // Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Order#',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                    order.CancelOrder.length,
                                        (index) {
                                      final item =
                                      order.CancelOrder[
                                      index];
                                      return DataRow(
                                        // color: index %
                                        //     2 ==
                                        //     0
                                        //     ? null
                                        //     : MaterialStateProperty
                                        //     .resolveWith(
                                        //     getColor),
                                        cells: [
                                          DataCell(
                                              StreamBuilder<Object>(
                                                  stream: null,
                                                  builder: (context, snapshot) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          item[
                                                          'od_stmp'],
                                                          style:
                                                          TextStyle(fontSize: allsize * 0.012),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              )),
                                          DataCell(
                                              Text(
                                                "${item['od_id']}",
                                                style: TextStyle(
                                                    color: const Color(0xff006ccf),
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                          DataCell(
                                              Text(
                                                "\$${item['total']}",
                                                style: TextStyle(
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Arcieve Orders
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(allsize*0.003),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Archive Orders",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.015,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: size.width*0.025),
                          child: Theme(
                            data: Theme.of(
                                context)
                                .copyWith(
                                dividerColor:
                                Colors
                                    .transparent),
                            child: SizedBox(
                              width: size.width*1,
                              child: DataTable(
                                headingRowColor:
                                MaterialStateProperty
                                    .resolveWith(
                                    getColor),
                                headingRowHeight:
                                size.height *
                                    0.025,
                                horizontalMargin:
                                0,
                                // columnSpacing:size.width*0.06,
                                // Add column spacing for better visibility
                                dataRowHeight:
                                size.height *
                                    0.025,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), // Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Order#',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Colors.grey[
                                          700],
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          allsize *
                                              0.012), //// Set text color for the heading
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                    order.ArchieveOrder.length,
                                        (index) {
                                      final item =
                                      order.ArchieveOrder[
                                      index];
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                              StreamBuilder<Object>(
                                                  stream: null,
                                                  builder: (context, snapshot) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          item[
                                                          'od_stmp'],
                                                          style:
                                                          TextStyle(fontSize: allsize * 0.012),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              )),
                                          DataCell(
                                              Text(
                                                "${item['od_id']}",
                                                style: TextStyle(
                                                    color: const Color(0xff006ccf),
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                          DataCell(
                                              Text(
                                                "\$${item['total']}",
                                                style: TextStyle(
                                                    fontSize:
                                                    allsize * 0.012),
                                              )),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ],
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
          );
        })),
      ),
    );
  }
}
