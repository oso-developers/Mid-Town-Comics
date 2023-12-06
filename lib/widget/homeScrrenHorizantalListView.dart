import 'package:midtowncomics/export.dart';

import 'featurenewrelease.dart';
class HomeScrrenHorizantalList extends StatefulWidget {
  ScrollController scrollController;
  PageController pageScrollController;
  List<dynamic>data;
   HomeScrrenHorizantalList({super.key,required this.data,required this.scrollController,required this.pageScrollController});

  @override
  State<HomeScrrenHorizantalList> createState() => _HomeScrrenHorizantalListState();
}

class _HomeScrrenHorizantalListState extends State<HomeScrrenHorizantalList> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return RawScrollbar(
      controller: widget.scrollController,
      thumbColor: const Color(0xff006ccf),
      trackVisibility: true,
      thickness: size.height*0.006,
      thumbVisibility: true,
      child: PageView.builder(
        controller: widget.pageScrollController,
        itemCount:
        (widget.data.length /
            2)
            .ceil(),
        // Display two items per page
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, pageIndex) {
          FunctionClass().precacheImages(
              widget.data,
              context);
          final startIndex = pageIndex * 2;
          final endIndex = startIndex + 2;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.013),
            child: Row(
              mainAxisAlignment: endIndex <=
                  widget.data
                      .length
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                for (var index = startIndex;
                index < endIndex;
                index++)
                  if (index <
                      widget.data
                          .length)
                    SizedBox(
                      child: FeatureNewRelease(
                        adultimage:widget.data[
                        index]['hideadultimage'],
                        pulllist:widget.data[
                        index]['su_id'],
                        image: widget.data[
                        index]['pr_id'],
                        title: widget.data[
                        index]['pr_ttle'],
                        prce1: widget.data[
                        index]['pr_price'],
                        price2:widget.data[
                        index]['pr_lprice'],
                        preorder: widget.data[
                        index]['pr_advord'],
                        quantity: int.parse(widget.data[
                        index]['pr_qty']),
                        incart: int.parse(
                            widget.data[
                        index]['in_cart']),
                        productquantity:
                        int.parse(
                            widget.data[
                        index]['pr_qty']),
                        qtycart: int.parse(
                            widget.data[
                        index]['sc_qty']),
                        data: widget.data[
                        index], parentid: widget.data[
                      index]['pr_parentid'],
                        addedtowl: int.parse(widget.data[index]['addedtowl']),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
