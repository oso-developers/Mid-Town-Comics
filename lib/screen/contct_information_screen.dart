
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class ContactInformationScreen extends StatefulWidget {
  const ContactInformationScreen({super.key});

  @override
  State<ContactInformationScreen> createState() =>
      _ContactInformationScreenState();
}

class _ContactInformationScreenState extends State<ContactInformationScreen> {
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
                  "About Us",
                  style:
                      TextStyle(fontSize:allsize*0.02, fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: size.height * 0.03,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: const Color(0xff00ACEE),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Colors.white,
                        size: allsize*0.013,
                      ),
                      Text(
                        "Follow Us @MidtownComics",
                        style: TextStyle(color: Colors.white,fontSize: allsize*0.011),
                      )
                    ],
                  ),
                )),
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
                           Text(
                            "Midtown Comics first opened its door in 1997 and has since become the leading"
                            " comic book retailer in the U.S. with its online store as well as three landmark"
                            " locations in New York City: Times Square, Grand Central and Downtown.\n"
                            "We always have the hottest publishers and trending topics available, including DC"
                            " Comics, Marvel Comics, the New Age of DC Heroes, Marvel Legacy, DC Rebirth, Image Comics,"
                            " and more! The greatest characters of all time are here too, including Batman, Superman, Wonder"
                            " Woman, Supergirl, Spider-Man, the Avengers, the Flash, Captain America, the X-Men, Green "
                            "Lantern, Wolverine, Black Widow, Thor, Daredevil, Dr. Strange, Jessica Jones, Iron Fist,"
                            " the Defenders, Captain Marvel, Ms. Marvel, the Punisher, Green Arrow, the Incredible Hulk, "
                            "Iron Man, Hellboy, Fantastic Four, the Walking Dead, iZombie, Luke Cage, Kingsman, Suicide Squad,"
                            " Harley Quinn, and more!\n"
                            "Midtown Comics is the go-to place for the best comic book subscription service to Marvel Comics, DC Comics,"
                            " and all publishers. DC Subscriptions, Marvel Subscriptions, and all subscriptions can be found"
                            " online or at our NYC stores!\n"
                            "Shop online: Midtown Comics is committed to providing great service and prices, and making the shopping experience"
                            " as much fun as reading and collecting. It's not just about comics! Midtown Comics offers a vast"
                            " selection of comic book related action figures, statues, movies, books and so much"
                            " more, all available online and in-store.\n"
                            "Creator Signings: Midtown's New York stores are home to many exciting creator signings."
                            " Our guest creators have included Brian Michael Bendis, Geoff Johns, Scott Snyder, Greg Capullo,"
                            " Garth Ennis, Frank Miller, Alex Ross, Jim Lee, Kevin Smith, Brian K. Vaughan, Mark Waid, Gail"
                            " Simone, J.G. Jones, Peter David, Greg Pak, Jeff Smith, Paul Dini, Greg Rucka, John Romita Jr."
                            " and Neal Adams to name a few. Many signed books and exclusive or variant covers"
                            " are available online.\n"
                            "New York Comic-Con: Midtown Comics is a retail sponsor of NYCC,"
                            " and has been associated with the con since inception. Midtown's NYCC"
                            " mega-booth includes discounts on all books, contests, prizes, and more!\n"
                            "Want to stay up to date with all things Midtown? Want access to exclusive deals and giveaways? Then follow us on "
                            "Twitter, Facebook, Instagram , Youtube, and more!",style: TextStyle(fontSize: allsize*0.011),),
                        const Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                           Text(
                          "Contact Us",
                          style: TextStyle(
                              fontSize:allsize*0.017, fontWeight: FontWeight.bold),
                        ),
                           Text(
                          "Email: info@midtowncomics.com\n"
                          "Tel:800.411.3341(or 212.302.8192)\n"
                          "If you're interested in selling your collection,please contact:\n"
                          "Email:webuy@midtowncomics.com\n"
                          "Tel:646.452.8173",
                          style: TextStyle(color: Colors.black54,fontSize: allsize*0.011),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                           Text(
                          "VISIT US IN NEW YORK CITY!",
                          style: TextStyle(
                              fontSize: allsize*0.017, fontWeight: FontWeight.bold),
                        ),
                           Text(
                          "Store Hours,info & Direction",
                          style: TextStyle(color: Colors.black54,fontSize: allsize*0.011),
                        ),
                        SizedBox(height: size.height*0.01,),
                        Center(
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/TS-a_300.jpg'),fit: BoxFit.fill)),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child:  Text(
                              'Times Square',
                              style: TextStyle(color: const Color(0xff006ccf),fontSize: allsize*0.011),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height*0.02,),
                        Center(
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/GC-a_300.jpg'),fit: BoxFit.fill)),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child:  Text(
                              'Grand Central',
                              style: TextStyle(color: const Color(0xff006ccf),fontSize: allsize*0.011),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height*0.02,),
                        Center(
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/DT-0_300.jpg'),fit: BoxFit.fill)),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Downtown',
                              style: TextStyle(color: Color(0xff006ccf)),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height*0.02,),

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
              height: size.height * 0.05,
            )
          ],
        )),
      ),
    );
  }
}
