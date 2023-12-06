
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize=size.height+size.width;
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "IN-STORE PICKUP",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //H1
                        const Text(
                          "Ordering for in-store pickup is easy and FUN!",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        //C1
                        const Text(
                          "\nOrder anything you like and proceed to checkout as usual. For your shipping option, select the store of your choice and pay with a credit card.\n"
                          "\n You’ll receive an email when we’re ready to send your order to the store, and within three days you’ll be able to pick it up at the store. You’ll"
                          " receive another e-mail when your order has arrived at the store of your choice. "
                          "Just bring a printed invoice and the credit card you used.",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        //H2
                        const Text(
                          "International customers:",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        //C2
                        const Text(
                          "\nIf you’re planning a visit to NYC soon, this is a great way to order from Midtown Comics, with NO shipping charges! Just pickup in-store during your visit.",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        //H3
                        const Text(
                          'The fine print:',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        //C3
                        const Text(
                          "\nAll comics, books, and back issues online are"
                          " discounted already, so your in-store rewards won’t apply,"
                          " nor will in-store sales. Our online sales do apply! Please come"
                          " in to pick up within two weeks to ensure your order"
                          " is still readily accessible. There are no exchanges, so please"
                          " review your order before you leave the store to make sure you’re satisfied.\n"
                          "\n Free pick up for Ebay items: If you’re in the NY area and would pick up your ebay"
                          " items at any Midtown Comics location, you can do so FREE! Simply"
                          " request it at checkout, and we’ll send your purchased eBay item to"
                          " the Midtown Comics location of your choice for you to pick up at your"
                          " convenience! (Please note, this is not same day pickup, and could take"
                          " up to three days for the item to be ready in store.)",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Footer(),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        )),
      ),
    );
  }
}
