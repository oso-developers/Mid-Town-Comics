import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';

class FunctionClass{
  List<String> generateStringListFromInteger(int count) {
    List<String> stringList = ["-Remove-"];
    for (int i = 1; i <= count; i++) {
      stringList.add('$i in Cart');
    }
    return stringList;
  }
  int extractIntegerBeforeSpace(String text) {
    List<String> parts = text.split(" ");
    if (parts.isNotEmpty) {
      String value = parts.first;
      return int.tryParse(value) ??
          0; // Convert to int or default to 0 if not a valid integer.
    } else {
      return 0; // Default value if no space is found.
    }
  }
  String findoff(String price1,String price2) {
    double percent =
        ((double.parse(price1) - double.parse(price2)) /
            double.parse(price1)) *
            100;
    String stringValue = percent.toString();
    List<String> parts = stringValue.split('.');
    String partBeforeDecimal = parts[0];
    return partBeforeDecimal;
  }
  void precacheImages(List<dynamic> imageUrls,BuildContext context) {
    for (final imageUrl in imageUrls) {
      precacheImage(
          NetworkImage(
              "https://www.midtowncomics.com/images/PRODUCT/FUL/${imageUrl['pr_id']}_ful.jpg"),
          context);
    }
  }
  bool isListLengthEven(List<dynamic> myList) {
    return myList.length % 2 == 0;
  }

  String searchgradevalue(String prid,List<dynamic>data){
    String value="";
    for (var product in data) {
      if (product["pr_id"] == prid) {
       value=product['condition_name'];
        break; // Exit the loop once the product is found and updated
      }
    }
    return value;
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    // Remove extra spaces
    String spaceRemove="";
    spaceRemove = parsedString.replaceAll(RegExp(r'\s+'), ' ');

    return spaceRemove;
  }


  //Convert Pre Code TO Date
  String convertToFullMonth(String input) {
    // Define a mapping for month abbreviations
    Map<String, String> monthAbbreviations = {
      'JAN': 'JANUARY',
      'FEB': 'FEBRUARY',
      'MAR': 'MARCH',
      'APR': 'APRIL',
      'MAY': 'MAY',
      'JUN': 'JUNE',
      'JUL': 'JULY',
      'AUG': 'AUGUST',
      'SEP': 'SEPTEMBER',
      'OCT': 'OCTOBER',
      'NOV': 'NOVEMBER',
      'DEC': 'DECEMBER',
    };

    // Extract month and year from the input
    String monthAbbreviation = input.substring(0, 3);
    String year = '20' + input.substring(3); // Add '20' at the start of the year

    // Convert month abbreviation to full month name
    String fullMonth = monthAbbreviations[monthAbbreviation] ?? 'UNKNOWN';

    // Combine full month and year
    String result = '$fullMonth $year';

    return result;
  }

  void main() {
    String input = 'JAN21';
    String output = convertToFullMonth(input);
    print(output); // Output: JANUARY 2021
  }

}