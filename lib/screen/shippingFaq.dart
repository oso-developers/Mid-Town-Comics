// ignore_for_file: library_private_types_in_public_api

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class ShippingFaqScreen extends StatefulWidget {
  const ShippingFaqScreen({super.key});

  @override
  State<ShippingFaqScreen> createState() => _ShippingFaqScreenState();
}

class _ShippingFaqScreenState extends State<ShippingFaqScreen> {
  final List<QuestionAnswer> data = [
    QuestionAnswer(
      question: 'How does Pre-Orders work?',
      answer:
          'When you submit Pre-Orders, you are placing an order 2-3 months in advance.'
          ' The items listed in Pre-Orders have not been released yet. After adding items to your cart and checking out, you will have to wait for the item(s) to be released by the publisher or manufacturer. (Release dates are available on each product page, and are subject to change by the publisher or manufacturer). When you place a Pre-Order, we are specifically ordering that item for you meaning even if run out of stock on the site, we still have your copy on reserve. Unfortunately, because Pre-Order items are ordered to match demand, we cannot cancel'
          ' a Pre-Orders once the Pre-Orders ordering window has closed.',
    ),
    QuestionAnswer(
      question: 'When will my Pre-Orders ship?',
      answer: 'There are three different shipping cycles:\n'
          'Weekly: Every week, all items released during that week will be packed up and a shipping rate calculated based on our shipping rates table.\n'
          'Bi-Weekly: Orders will be shipped every two weeks.\n'
          'Monthly: Pre-ordered items will be bundled up and shipped together every four weeks on a revolving cycle. They will not be bundled up for shipment at the end of every month. Please note that our monthly cycle option does not directly correspond with a calendar month, because some months have five Wednesdays. Monthly shipments will nevertheless always ship four weeks apart.\n'
          'If you select monthly shipping, you may have to wait for your shipment, but you\'ll receive more items in one shipment, saving you money on the shipping cost. If you select weekly, you\'ll get your orders faster, although you\'ll usually pay more in shipping. Nevertheless, if you\'re only ordering one item, you\'re better off with weekly.',
    ),
    QuestionAnswer(
      question: 'When will I be charged for shipping on Pre-Orders?',
      answer:
          'We have an all new way of processing Pre-Orders. Instead of paying for the items now and waiting till the order is ready to ship for a shipping charge, you will now receive all shipping charges upfront. Shipping amounts will depend on item release dates and shipping cycle.\n'
          'If you decide to add more items later on, you will only be charged the difference.\n'
          'PLEASE NOTE: The new processing method only affects Domestic customers. International customers will continue using the existing method of paying for shipping when the order is ready to ship since we would have to weigh all the items in the order.',
    ),
    QuestionAnswer(
      question: 'Are there any benefits when placing a Pre-Order?',
      answer:
          'Of course! Aside from getting the unbeatable discounts Pre-Orders have to offer, you’ll see your shipping cost upfront - no more wondering how much shipping will cost you when the items are ready to go out. And you now can pay'
          ' for your entire Pre-Orders (shipping included) with PayPal or your credit card.',
    ),
    QuestionAnswer(
      question: 'What if I place a Pre-Order and the item’s price changes?',
      answer:
          'Prices for preordered items are subject to change, and on rare occasions we may be forced to adjust a price before filling an order. If the price change is \$5.00 or less this will be charged automatically, if it is higher we will'
          ' reach out to you first! (we give refunds for price drop without asking you first, of course!)',
    ),
    // Add more questions and answers as needed
  ];
  bool defaultshipping = true;
  bool defaultbilling = true;
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
                  "FAQ",
                  style:
                      TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return QuestionAnswerTile(questionAnswer: data[index]);
                  },
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            const SubcribeWidget(),
            SizedBox(
              height: size.height * 0.02,
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

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}

class QuestionAnswerTile extends StatefulWidget {
  final QuestionAnswer questionAnswer;

  const QuestionAnswerTile({super.key, required this.questionAnswer});

  @override
  _QuestionAnswerTileState createState() => _QuestionAnswerTileState();
}

class _QuestionAnswerTileState extends State<QuestionAnswerTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(widget.questionAnswer.question),
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.questionAnswer.answer),
          ),
        ],
      ),
    );
  }
}
