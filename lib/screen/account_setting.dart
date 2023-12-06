import 'package:midtowncomics/export.dart';

import '../provider/settingProvider.dart';
import '../widget/dialagueBox/editProfileDialugue.dart';
import '../widget/searchList.dart';

class MyAccountSetting extends StatefulWidget {
  const MyAccountSetting({super.key});

  @override
  State<MyAccountSetting> createState() => _MyAccountSettingState();
}

class _MyAccountSettingState extends State<MyAccountSetting> {
  TextEditingController searchController=TextEditingController();
  bool active = true;
  String shippingAddressCountry = "";

  bool get isTablet {
    final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalShortestSide =
        firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
    return logicalShortestSide > 600;
  }

  Color getColor(Set<MaterialState> states) {
    return const Color(0xffececec);
  }


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    setState(() {
      final account =
          Provider.of<AccountSettingProvider>(context, listen: false);
      if (account.pullListSetting.isNotEmpty) {
        active = false;
        active = account.AccountSettingData['DATA']['pullListSetting']
                    ['ss_active'] ==
                "0"
            ? false
            : true;
      } else {
        active = true;
      }
    });
    // TODO: implement initState
    super.initState();
  }

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
        body: SingleChildScrollView(child:
        Consumer<AccountSettingProvider>(
            builder: (context, account, child) {
          return account.AccountSettingData.isEmpty
              ? const Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchList(searchcontroller:searchController,),
                    Container(
                      height: size.height*0.065,
                      color: Colors.grey[200],
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "My Account Setting",
                          style: TextStyle(
                              fontSize: allsize * 0.02,
                              fontFamily: 'oswald_bold',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditProfileDialague(
                                firstName: account.profiledata['sh_fname'],
                                lastName: account.profiledata['sh_lname'],
                                dob: account.profiledata['sh_dob'],
                                email: account.profiledata['sh_lgid'],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              "My Profile",
                              style: TextStyle(
                                  color: const Color(0xff006ccf),
                                  fontSize: allsize * 0.016,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              color: const Color(0xff006ccf),
                              size: allsize * 0.02,
                            )
                          ],
                        )),
                    MyProfileRow(
                        title: "Name:",
                        value: account.profiledata['sh_fname'] +
                            " " +
                            account.profiledata['sh_lname']),
                    MyProfileRow(
                        title: "Date of Birth:",
                        value: account.profiledata['sh_dob']),
                    MyProfileRow(
                        title: "Email:",
                        value: account.profiledata['sh_lgid']),
                    MyProfileRow(title: "Password:", value: "******"),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "My Orders",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontSize: allsize * 0.015,
                              fontWeight: FontWeight.bold),
                        )),
                    // Pending Orders
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            "Pending",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: allsize * 0.012,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(const MyOrderScreen());
                              },
                              child: Text(
                                "(VIEW ALL)",
                                style: TextStyle(
                                    color: const Color(0xff006ccf),
                                    fontSize: allsize * 0.011,
                                  fontWeight: FontWeight.bold
                                ),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.025),
                      child: Table(
                        defaultColumnWidth:
                            FixedColumnWidth(size.width * 0.35),
                        // const <int, TableColumnWidth>{
                        //   0: FlexColumnWidth(3), // Title
                        //   1: FlexColumnWidth(1), // Qty
                        //   2: FlexColumnWidth(1), // Type
                        //   3: FlexColumnWidth(1), // Total
                        //   4: FlexColumnWidth(1), // Action
                        // },
                        // border: TableBorder.all(color: Colors.grey),
                        // defaultColumnWidth: FixedColumnWidth(size.width * 0.2),
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(
                                color: Color(0xffececec)),
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                              Text(
                                'Order#',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                              Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                            ],
                          ),
                          // Generate table rows
                          for (var item in account.orderinprocess)
                            TableRow(
                              children: [
                                Text(
                                  "${item['od_stmp']}",
                                  style: TextStyle(
                                      fontSize: allsize * 0.012),
                                ),
                                Text(
                                  item['od_id'],
                                  style: TextStyle(
                                    fontSize: allsize * 0.012,
                                    color: const Color(0xff006ccf),
                                  ),
                                ),
                                Text(
                                  "\$${item['order_total']}",
                                  style: TextStyle(
                                      fontSize: allsize * 0.012),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    //Shipped
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            "Shipped",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: allsize * 0.012),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(const MyOrderScreen());
                              },
                              child: Text(
                                "(VIEW ALL)",
                                style: TextStyle(
                                    color: const Color(0xff006ccf),
                                    fontSize: allsize * 0.011,fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.025),
                      child: Table(
                        defaultColumnWidth:
                            FixedColumnWidth(size.width * 0.25),
                        // const <int, TableColumnWidth>{
                        //   0: FlexColumnWidth(3), // Title
                        //   1: FlexColumnWidth(1), // Qty
                        //   2: FlexColumnWidth(1), // Type
                        //   3: FlexColumnWidth(1), // Total
                        //   4: FlexColumnWidth(1), // Action
                        // },
                        // border: TableBorder.all(color: Colors.grey),
                        // defaultColumnWidth: FixedColumnWidth(size.width * 0.2),
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(
                                color: Color(0xffececec)),
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                              Text(
                                'Order#',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                              Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                              Text(
                                'Tracking',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                            ],
                          ),
                          // Generate table rows
                          for (var item in account.Shippedorder)
                            TableRow(
                              children: [
                                Center(
                                  child: Text(
                                    "${item['od_stmp']}",
                                    style: TextStyle(
                                        fontSize: allsize * 0.012),
                                  ),
                                ),
                                Text(
                                  item['od_id'],
                                  style: TextStyle(
                                    fontSize: allsize * 0.012,
                                    color: const Color(0xff006ccf),
                                  ),
                                ),
                                Text(
                                  "\$${item['order_total']}",
                                  style: TextStyle(
                                      fontSize: allsize * 0.012),
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: allsize * 0.012,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    //Declined
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            "Declined",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: allsize * 0.012),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(const MyOrderScreen());
                              },
                              child: Text(
                                "(VIEW ALL)",
                                style: TextStyle(
                                    color: const Color(0xff006ccf),
                                    fontSize: allsize * 0.011,fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.025),
                      child: Table(
                        defaultColumnWidth:
                            FixedColumnWidth(size.width * 0.35),
                        // const <int, TableColumnWidth>{
                        //   0: FlexColumnWidth(3), // Title
                        //   1: FlexColumnWidth(1), // Qty
                        //   2: FlexColumnWidth(1), // Type
                        //   3: FlexColumnWidth(1), // Total
                        //   4: FlexColumnWidth(1), // Action
                        // },
                        // border: TableBorder.all(color: Colors.grey),
                        // defaultColumnWidth: FixedColumnWidth(size.width * 0.2),
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(
                                color: Color(0xffececec)),
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                              Text(
                                'Order#',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                              Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                            ],
                          ),
                          // Generate table rows
                          for (var item in account.declinedorder)
                            TableRow(
                              children: [
                                Center(
                                  child: Text(
                                    "${item['od_stmp']}",
                                    style: TextStyle(
                                        fontSize: allsize * 0.012),
                                  ),
                                ),
                                Text(
                                  item['od_id'],
                                  style: TextStyle(
                                    fontSize: allsize * 0.012,
                                    color: const Color(0xff006ccf),
                                  ),
                                ),
                                Text(
                                  "\$${item['order_total']}",
                                  style: TextStyle(
                                      fontSize: allsize * 0.012),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    //My Pull List
                    AccountSettingMyPulllist(
                        allsize, size, context, account),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    AccountSettingPreviewSetting(
                        allsize, size, context, account),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    account.pullListItem.isNotEmpty
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Upcoming Pull List Items",
                              style: TextStyle(
                                  color: const Color(0xff006ccf),
                                  fontSize: allsize * 0.016,
                                  fontWeight: FontWeight.bold),
                            ))
                        : Container(),
                    account.pullListItem.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.025),
                            child: Table(
                              columnWidths: const <int, TableColumnWidth>{
                                0: FlexColumnWidth(3), // Title
                                1: FlexColumnWidth(1), // Qty
                                2: FlexColumnWidth(1), // Type
                                3: FlexColumnWidth(1), // Total
                                4: FlexColumnWidth(1), // Action
                              },
                              // border: TableBorder.all(color: Colors.grey),
                              // defaultColumnWidth: FixedColumnWidth(size.width * 0.2),
                              children: [
                                TableRow(
                                  decoration: const BoxDecoration(
                                      color: Color(0xffececec)),
                                  children: [
                                    Center(
                                      child: Text(
                                        'Title',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: allsize * 0.012,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Qty',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: allsize * 0.012,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Type',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: allsize * 0.012,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Total',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: allsize * 0.012,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Actions',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: allsize * 0.012,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Generate table rows
                                for (var item in account.pullListItem)
                                  TableRow(
                                    children: [
                                      Center(
                                        child: Text(
                                          item['pr_ttle'],
                                          style: TextStyle(
                                              fontSize: allsize * 0.012),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "${item['sc_qty']}",
                                          style: TextStyle(
                                              fontSize: allsize * 0.012),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          item['type'],
                                          style: TextStyle(
                                              fontSize: allsize * 0.012),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "\$${item['pr_lprice']}",
                                          style: TextStyle(
                                              fontSize: allsize * 0.012),
                                        ),
                                      ),
                                      Center(
                                        child: item['fetchtype'] ==
                                                    'SUBDETAIL' &&
                                                item['susp'] == '1'
                                            ? InkWell(
                                            child: const Icon(Icons.play_arrow),
                                          onTap: (){
                                            final streamedDataProvider =
                                            Provider.of<StreamedDataProvider>(context,
                                                listen: false);
                                              ApiRequests().upcomingPullList(streamedDataProvider.loginuserdata['sh_id'],item['pr_id'],item['fetchtype'],item['su_id'],"0", context);
                                              },
                                        )
                                            : item['fetchtype'] ==
                                                        'SUBDETAIL' &&
                                                    item['susp'] == '0'
                                                ? InkWell(child:
                                        const Icon(Icons.pause),
                                          onTap: (){
                                            final streamedDataProvider =
                                            Provider.of<StreamedDataProvider>(context,
                                                listen: false);
                                            ApiRequests().upcomingPullList(streamedDataProvider.loginuserdata['sh_id'],item['pr_id'],item['fetchtype'],item['su_id'],"1", context);
                                          },
                                        )
                                                : item['fetchtype'] ==
                                                        'TCART'
                                                    ? InkWell(
                                                      child: const Icon(
                                                          Icons.delete),
                                          onTap: (){

                                            final streamedDataProvider =
                                            Provider.of<StreamedDataProvider>(context,
                                                listen: false);

                                            ApiRequests().upcomingPullList(streamedDataProvider.loginuserdata['sh_id'],item['pr_id'],item['fetchtype'],"0","0", context);
                                          },
                                                    )
                                                    : Text(
                                                        "-",
                                                        style: TextStyle(
                                                            fontSize:
                                                                allsize *
                                                                    0.012),
                                                      ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          )
                        : Container(),
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

  Column AccountSettingPreviewSetting(double allsize, Size size,
      BuildContext context, AccountSettingProvider account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "My Previews",
              style: TextStyle(
                  color: const Color(0xff006ccf),
                  fontSize: allsize * 0.016,
                  fontWeight: FontWeight.bold),
            )),
        //Credit Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: size.height * 0.045,
            // color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Credit Card",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: allsize * 0.016,
                                vertical: allsize * 0.04),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: account.creditCard
                                    .map<Widget>((dynamic item) {
                                  return ListTile(
                                    title: Text(item['pm_cardnum']),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      account.updatePreviewSettingCreditCard(
                                          item['pm_cardnum']);
                                      account
                                          .updatePreviewSettingCreditCardValue(
                                              item['pm_id']);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: size.width * 0.5,
                      decoration: const BoxDecoration(
                          // color:
                          // Colors.grey[300]
                          ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              account.previewSettingCreditCard,
                              style: TextStyle(fontSize: allsize * 0.012),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: allsize * 0.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //Billing Address
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: size.height * 0.045,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Billing Address",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: allsize * 0.016,
                                vertical: allsize * 0.04),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: account.addressList
                                    .map<Widget>((dynamic item) {
                                  return ListTile(
                                    title: Text(FunctionClass()
                                        .parseHtmlString(item['full_address'])),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      account.updatePreviewBillingAddress(
                                          FunctionClass().parseHtmlString(
                                              item['full_address']));
                                      account.updatePreviewBillingAddressValue(
                                          item['sa_id']);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: size.width * 0.5,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              FunctionClass().parseHtmlString(
                                  account.previewSettingBillingAddress),
                              style: TextStyle(fontSize: allsize * 0.012),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: allsize * 0.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: size.height * 0.05,
            // color: Colors.grey[300]
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Frequency",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: allsize * 0.016,
                                vertical: allsize * 0.04),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: account.shippingFrequency
                                    .map<Widget>((dynamic item) {
                                  return ListTile(
                                    title: Text(item['ssbillcycle_value']),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      account.updatePreviewShippingFrequency(
                                          item['ssbillcycle_value']);
                                      account.updateShippingFrequencyApi(
                                          item['ssbillcycle_value']);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: InkWell(
                      onTap: (){
                        print(account.previewSettingShippingFrequency);
                      },
                      child: Container(
                        width: size.width * 0.5,
                        // decoration: BoxDecoration(
                        //     color:
                        //     Colors.grey[300]),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                account.previewSettingShippingFrequency,
                                style: TextStyle(fontSize: allsize * 0.012),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: allsize * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            // height: size.height * 0.04,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Address",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        account.previewSetting['previews_pending_count'] == "0"
                            ? Container()
                            : account.previewSetting.isEmpty
                                ? Container()
                                : Text(
                                    FunctionClass().parseHtmlString(
                                        account.previewSettingShippingAddress),
                                    style: TextStyle(fontSize: allsize * 0.012),
                                  ),
                        account.previewSetting['previews_pending_count'] ==
                                    "0" ||
                                account.previewSetting.isEmpty
                            ? SizedBox(
                                // height: size.height * 0.045,
                                // color: Colors.grey[300],
                                child: Column(
                                children: [
                                  account.previewSetting[
                                                  'previews_pending_count'] ==
                                              "0" ||
                                          account.previewSetting.isEmpty
                                      ? InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  insetPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal:
                                                              allsize * 0.016,
                                                          vertical:
                                                              allsize * 0.04),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: account
                                                          .addressList
                                                          .map<Widget>(
                                                              (dynamic item) {
                                                        return ListTile(
                                                          title: Text(FunctionClass()
                                                              .parseHtmlString(item[
                                                                  'full_address'])),
                                                          onTap: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            account.updatePreviewShippingAddress(
                                                                FunctionClass()
                                                                    .parseHtmlString(
                                                                        item[
                                                                            'full_address']));
                                                            account.updatePreviewShippingAddressValue(
                                                                "item['full_address']");
                                                          },
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: size.width * 0.5,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300]),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    FunctionClass()
                                                        .parseHtmlString(account
                                                            .previewSettingShippingAddress),
                                                    style: TextStyle(
                                                        fontSize:
                                                            allsize * 0.012),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  size: allsize * 0.02,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ))
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: size.height * 0.05,
            // color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Method",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      children: [
                        account.previewSetting['previews_pending_count'] ==
                                    "0" ||
                                account.previewSetting.isEmpty
                            ? Container()
                            : Flexible(
                                child: Text(
                                account.previewSettingShippingMethod,
                                style: TextStyle(fontSize: allsize * 0.012),
                              )),
                        account.previewSetting['previews_pending_count'] ==
                                    "0" ||
                                account.previewSetting.isEmpty
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: allsize * 0.016,
                                            vertical: allsize * 0.04),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: account.shippingMethodUSA
                                                .map<Widget>((dynamic item) {
                                              return ListTile(
                                                title: Text(
                                                    item['shipping_method']),
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  account
                                                      .updateShippingMethodVariable(
                                                          item[
                                                              'shipping_method']);
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: size.width * 0.5,
                                  decoration: const BoxDecoration(
                                      // color:
                                      // Colors.grey[300]
                                      ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          account.shippingMethodVariable,
                                          style: TextStyle(
                                              fontSize: allsize * 0.012),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: allsize * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        //Save Preview Setting Button
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: size.height * 0.06,
              color: const Color(0xff006ccf),
              child: Center(
                child: Text(
                  "SAVE PREVIEW SETTINGS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: allsize * 0.016,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          onTap: () {
            final streamedDataProvider =
                Provider.of<StreamedDataProvider>(context, listen: false);
            ApiRequests().SavePreviewSetting(
                streamedDataProvider.loginuserdata['sh_id'],
                account.previewSettingCreditCardValue,
                account.previewSettingBillingAddressValue,
                account.previewSettingShippingFrequencyValue,
                account.previewSettingShippingAddressValue,
                account.previewSettingShippingMethodValue,
                context);
          },
        ),
      ],
    );
  }

  Column AccountSettingMyPulllist(double allsize, Size size,
      BuildContext context, AccountSettingProvider account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "My Pull List",
              style: TextStyle(
                  color: const Color(0xff006ccf),
                  fontSize: allsize * 0.015,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Pull List Status",
              style: TextStyle(color: Colors.grey, fontSize: allsize * 0.0112),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: allsize * 0.0007,
                  child: Radio(
                    activeColor: const Color(0xff006ccf),
                    value: true,
                    groupValue: active,
                    onChanged: (val) {
                      setState(() {
                        active = val as bool;
                        print(active);
                      });
                    },
                  ),
                ),
                Text(
                  "Active",
                  style: TextStyle(fontSize: allsize * 0.012),
                )
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: allsize * 0.0007,
                  child: Radio(
                    activeColor: const Color(0xff006ccf),
                    value: false,
                    groupValue: active,
                    onChanged: (val) {
                      setState(() {
                        active = val as bool;
                        print(active);
                      });
                    },
                  ),
                ),
                Text(
                  "Inactive",
                  style: TextStyle(fontSize: allsize * 0.012),
                ),
              ],
            ),
          ],
        ),

        //Subcription Type
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: size.height * 0.045,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subscription Type",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: allsize * 0.016,
                                vertical: allsize * 0.04),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: account.subscriptionType
                                    .map<Widget>((dynamic item) {
                                  return ListTile(
                                    title: Text(item['sub_type_name']),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      account.updateSubscriptionVariable(
                                          item['sub_type_name']);
                                      account.updateSubscriptionTypeApi(
                                          item['sub_type']);
                                      if (item['sub_type'] ==
                                          'Mail Order Delivery') {
                                        // account.updateLocation(
                                        //     'Select Store Location');
                                        account.updateShippingFrequencyVariable(
                                            "Select Shipping Frequency");
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: size.width * 0.5,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              account.subscriptionTypeVariable,
                              style: TextStyle(fontSize: allsize * 0.012),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: allsize * 0.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //Shipping Frequency
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: size.height * 0.045,
            // color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Frequency",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  account.subscriptionTypeVariable == "Mail Order Delivery"
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: allsize * 0.016,
                                      vertical: allsize * 0.04),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: account.shippingFrequency
                                          .map<Widget>((dynamic item) {
                                        return ListTile(
                                          title: Text(
                                            item['ssbillcycle_value'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                            account
                                                .updateShippingFrequencyVariable(
                                                    item['ssbillcycle_value']);
                                            account.updateShippingFrequencyApi(
                                                item['ssbillcycle_value']);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: size.width * 0.5,
                            // decoration: BoxDecoration(
                            //     color:
                            //     Colors.grey[300]),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    account.shippingFrequencyVariable,
                                    style: TextStyle(fontSize: allsize * 0.012),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: allsize * 0.02,
                                ),
                              ],
                            ),
                          ),
                        )
                      : account.subscriptionTypeVariable == "In-Store Pickup"
                          ? InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          horizontal: allsize * 0.016,
                                          vertical: allsize * 0.04),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: account
                                              .shippingFrequencyInStore
                                              .map<Widget>((dynamic item) {
                                            return ListTile(
                                              title: Text(
                                                item['ssbillcycle_value'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                account
                                                    .updateShippingFrequencyVariable(
                                                        item[
                                                            'ssbillcycle_value']);
                                                account
                                                    .updateShippingFrequencyApi(
                                                        item['ssbillcycle']);
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: size.width * 0.5,
                                // decoration: BoxDecoration(
                                //     color:
                                //     Colors.grey[300]),
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        account.shippingFrequencyVariable,
                                        style: TextStyle(
                                            fontSize: allsize * 0.012),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: allsize * 0.02,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          horizontal: allsize * 0.016,
                                          vertical: allsize * 0.04),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: account
                                              .shippingFrequentExtra
                                              .map<Widget>((dynamic item) {
                                            return ListTile(
                                              title: Text(
                                                item['ssbillcycle_value'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                account
                                                    .updateShippingFrequencyVariable(
                                                        item[
                                                            'ssbillcycle_value']);
                                                // account.updateShippingFrequencyApi(
                                                //     item['ssbillcycle']);
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: size.width * 0.5,
                                // decoration: BoxDecoration(
                                //     color:
                                //     Colors.grey[300]),
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        account.shippingFrequencyVariable,
                                        style: TextStyle(
                                            fontSize: allsize * 0.012),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: allsize * 0.02,
                                    ),
                                  ],
                                ),
                              ),
                            )
                ],
              ),
            ),
          ),
        ),
        //Location
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: size.height * 0.045,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Location", style: TextStyle(fontSize: allsize * 0.012)),
                  InkWell(
                    onTap: account.subscriptionTypeVariable ==
                            "Mail Order Delivery"
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: allsize * 0.016,
                                      vertical: allsize * 0.04),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: account.location
                                          .map<Widget>((dynamic item) {
                                        return ListTile(
                                          title: Text(
                                            item['ss_location_address'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                            // account.shippingMethodInStore
                                            //     .clear();
                                            if (account.shippingAddressInStore
                                                    .length >
                                                1) {
                                              account.shippingAddressInStore
                                                  .removeLast();
                                            }
                                            String data =
                                                item['ss_location_address'];
                                            var parts = data.split('-');
                                            account.updateLocation(
                                                item['ss_location_address']);
                                            account.updateLocationApi(
                                                item['ss_location']);
                                            // account
                                            //     .addDataToShippingAddressInStore(
                                            //         item);
                                            if (item['ss_location'] == "40") {
                                              account.shippingAddressInStore
                                                  .add({
                                                "sa_id": "40",
                                                "ss_location_address":
                                                    "Time Square Store Address,${account.profiledata['sh_fname']} ${account.profiledata['sh_lname']},${parts[1]}"
                                              });
                                              account.addShippingMethod({
                                                "id": "40",
                                                "shipping_method":
                                                    "In-Store Pick up - Times Square"
                                              });
                                            } else if (item['ss_location'] ==
                                                "45") {
                                              account.shippingAddressInStore
                                                  .add({
                                                "sa_id": "45",
                                                "ss_location_address":
                                                    "Grand Central Store Address,${account.profiledata['sh_fname']} ${account.profiledata['sh_lname']},${parts[1]}"
                                              });
                                              account.addShippingMethod({
                                                "id": "45",
                                                "shipping_method":
                                                    'In-Store Pick up - Grand Central'
                                              });
                                            } else if (item['ss_location'] ==
                                                "64") {
                                              account.shippingAddressInStore
                                                  .add({
                                                "sa_id": "64",
                                                "ss_location_address":
                                                    "Downtown Store Address,${account.profiledata['sh_fname']} ${account.profiledata['sh_lname']},${parts[1]}"
                                              });
                                              account.addShippingMethod({
                                                "id": "64",
                                                "shipping_method":
                                                    'In-Store Pick up - Downtown'
                                              });
                                            } else if (item['ss_location'] ==
                                                "32") {
                                              account.shippingAddressInStore
                                                  .add({
                                                "sa_id": "32",
                                                "ss_location_address":
                                                    "Midtown Comics queens,${account.profiledata['sh_fname']} ${account.profiledata['sh_lname']},${parts[1]}"
                                              });
                                              account.addShippingMethod({
                                                "id": "32",
                                                "shipping_method":
                                                    'In-Store Pick up - Astoria'
                                              });
                                            }
                                            // account.updateShippingAddressVariable(
                                            //     account.addingShippingAddress[0]
                                            //         ['ss_location_address']);
                                            // account
                                            //     .updateShippingAddressApi("");
                                            // account.updateShippingMethodVariable(
                                            //     account.shippingMethodInStore[0]
                                            //         ['shipping_method']);
                                            // account.updateShippingMethodApi("");
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                    child: Container(
                      width: size.width * 0.5,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              account.locationVariable,
                              style: TextStyle(
                                  fontSize: allsize * 0.012,
                                  color: account.subscriptionTypeVariable ==
                                          "Mail Order Delivery"
                                      ? Colors.grey[500]
                                      : Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: account.subscriptionTypeVariable ==
                                    "Mail Order Delivery"
                                ? Colors.grey[500]
                                : Colors.black,
                            size: allsize * 0.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //Shipping Address

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            // height: size.height * 0.04,
            // color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Address",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        account.subscriptionTypeVariable == "In-Store Pickup"
                            ? Container()
                            : Text(
                                FunctionClass().parseHtmlString(
                                    account.shippingAddressVariable),
                                style: TextStyle(fontSize: allsize * 0.012),
                              ),
                        SizedBox(
                          height: size.height * 0.045,
                          // color: Colors.grey[300],
                          child: account.subscriptionTypeVariable ==
                                  "In-Store Pickup"
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: allsize * 0.016,
                                              vertical: allsize * 0.04),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: account
                                                  .shippingAddressInStore
                                                  .map<Widget>((dynamic item) {
                                                return ListTile(
                                                  title: Text(
                                                    item['ss_location_address'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    account.updateShippingAddressVariable(
                                                        item[
                                                            'ss_location_address']);
                                                    // account
                                                    // .updateShippingMethodApi(
                                                    //     item[
                                                    //         'ss_location']);
                                                    if (item['ss_location'] ==
                                                        '40') {
                                                      // account
                                                      //     .addShippingMethod({
                                                      //   "id": "",
                                                      //   "shipping_method":
                                                      //       "Select Shipping Method"
                                                      // });
                                                    }
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: size.width * 0.5,
                                    // decoration: BoxDecoration(color: Colors.grey[300]),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            account.shippingAddressVariable,
                                            style: TextStyle(
                                                fontSize: allsize * 0.012),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: allsize * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: allsize * 0.016,
                                              vertical: allsize * 0.04),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: account.addressList
                                                  .map<Widget>((dynamic item) {
                                                return ListTile(
                                                  title: Text(
                                                    FunctionClass()
                                                        .parseHtmlString(item[
                                                            'full_address']),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  onTap: () async {
                                                    account.updateShippingAddressVariable(
                                                        "${item['full_name']}\n${item['sa_desc']} ${item['sa_addr1']}\n"
                                                        " ${item['sa_addr2']}\n ${item['sa_city']},${item['sa_state']} ${item['sa_zip']}\n"
                                                        "${item['country_name']}");
                                                    // account.updateShippingAddressVariable(
                                                    //     FunctionClass()
                                                    //         .parseHtmlString(item[
                                                    //             'full_address']));
                                                    account
                                                        .updateShippingAddressApi(
                                                            item['sa_id']);
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: size.width * 0.5,
                                    decoration: const BoxDecoration(
                                        // color:
                                        // Colors.grey[300]
                                        ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            FunctionClass().parseHtmlString(
                                                account
                                                    .shippingAddressVariable),
                                            style: TextStyle(
                                                fontSize: allsize * 0.012),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: allsize * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //Shipping Method
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: size.height * 0.045,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Method",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  if (account.subscriptionTypeVariable == "Mail Order Delivery")
                    shippingAddressCountry == '840' ||
                            shippingAddressCountry == ""
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal: allsize * 0.016,
                                        vertical: allsize * 0.04),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: account.shippingMethodUSA
                                            .map<Widget>((dynamic item) {
                                          return ListTile(
                                            title: Text(
                                              item['shipping_method'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              account
                                                  .updateShippingMethodVariable(
                                                      item['shipping_method']);
                                              print(item['id']);
                                              account.updateShippingMethodApi(
                                                  item['id']);
                                              print(account.shippingMethodApi);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: size.width * 0.5,
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      account.shippingMethodVariable,
                                      style:
                                          TextStyle(fontSize: allsize * 0.012),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: allsize * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal: allsize * 0.016,
                                        vertical: allsize * 0.04),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: account.shippingMethodInter
                                            .map<Widget>((dynamic item) {
                                          return ListTile(
                                            title: Text(
                                              item['shipping_method'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              account
                                                  .updateShippingMethodVariable(
                                                      item['shipping_method']);
                                              print(item['id']);
                                              account.updateShippingMethodApi(
                                                  item['id']);
                                              print(account.shippingMethodApi);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: size.width * 0.5,
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      account.shippingMethodVariable,
                                      style:
                                          TextStyle(fontSize: allsize * 0.012),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: allsize * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          )
                  else
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              insetPadding: EdgeInsets.symmetric(
                                  horizontal: allsize * 0.016,
                                  vertical: allsize * 0.04),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: account.shippingMethodInStore
                                      .map<Widget>((dynamic item) {
                                    return ListTile(
                                      title: Text(
                                        item['shipping_method'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        account.updateShippingMethodVariable(
                                            item['shipping_method']);
                                        account.updateShippingMethodApi(
                                            item['id']);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: size.width * 0.5,
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                account.shippingMethodVariable,
                                style: TextStyle(fontSize: allsize * 0.012),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: allsize * 0.02,
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
        //Billing Address
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Billing Address",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      children: [
                        Text(
                          FunctionClass()
                              .parseHtmlString(account.billingAddressVariable),
                          style: TextStyle(fontSize: allsize * 0.012),
                        ),
                        SizedBox(
                          height: size.height * 0.045,
                          // color: Colors.grey[300],
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal: allsize * 0.016,
                                        vertical: allsize * 0.04),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: account.addressList
                                            .map<Widget>((dynamic item) {
                                          return ListTile(
                                            title: Text(
                                              FunctionClass().parseHtmlString(
                                                  item['full_address']),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              account
                                                  .updateBillingAddressVariable(
                                                      FunctionClass()
                                                          .parseHtmlString(item[
                                                              'full_address']));
                                              account.updateBillingAddressApi(
                                                  item['sa_id']);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: size.width * 0.5,
                              decoration: const BoxDecoration(
                                  // color:
                                  // Colors.grey[300]
                                  ),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      FunctionClass().parseHtmlString(
                                          account.billingAddressVariable),
                                      style:
                                          TextStyle(fontSize: allsize * 0.012),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: allsize * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //Credit Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: size.height * 0.045,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Credit Card",
                      style: TextStyle(fontSize: allsize * 0.012)),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: allsize * 0.016,
                                vertical: allsize * 0.04),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: account.creditCard
                                    .map<Widget>((dynamic item) {
                                  return ListTile(
                                    title: Text(item['pm_cardnum']),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      account.updateCreditCardVariable(
                                          item['pm_cardnum']);
                                      account
                                          .updateCreditCardApi(item['pm_id']);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: size.width * 0.5,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              account.creditCardVariable,
                              style: TextStyle(fontSize: allsize * 0.012),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: allsize * 0.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        //Save Pull List Button
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: size.height * 0.06,
              color: const Color(0xff006ccf),
              child: Center(
                child: Text(
                  "SAVE PULL SETTINGS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: allsize * 0.016,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          onTap: () {
            final streamedDataProvider =
                Provider.of<StreamedDataProvider>(context, listen: false);
            print(active == true ? "1" : "0");
            print(account.subscriptionTypeApi);
            print(account.shippingFrequencyApi);
            print(account.shippingMethodVariable);
            print(account.shippingMethodApi);
            print(account.shippingFrequencyApi);
            ApiRequests().SavePullListSetting(
                streamedDataProvider.loginuserdata['sh_id'],
                account.subscriptionTypeApi,
                account.shippingFrequencyApi,
                account.shippingMethodApi,
                // account.subscriptionTypeVariable == "Mail Order Delivery"
                //     ?
                account.shippingAddressApi,
                // : account.locationApi,
                account.billingAddressApi,
                account.creditCardApi,
                // account.shippingAddressApi,
                account.subscriptionTypeVariable == "Mail Order Delivery"
                    ? ""
                    : account.locationApi,
                active == true ? "1" : "0",
                context);
          },
        ),
      ],
    );
  }
}
