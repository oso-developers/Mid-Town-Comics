import 'package:flutter/material.dart';

class CustomDropDownGrade extends StatelessWidget {
  final List<dynamic> items;
  final Function(dynamic) onTapCallback;
  final String groupValue;
  final String name;
  double sizeValue;

  CustomDropDownGrade({super.key, 
    required this.items,
    required this.onTapCallback,
    required this.groupValue,
    required this.sizeValue,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    var size=MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: allsize * 0.016,
                vertical: allsize * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items.map<Widget>((dynamic item) {
                    return ListTile(
                      title: Text(name==""?item:item[name]),
                      onTap: () async {
                        onTapCallback(item);
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
        height: size.height * sizeValue,
        decoration: BoxDecoration(color: Colors.grey[300]),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              groupValue,
              style: TextStyle(fontSize: allsize * 0.014),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: allsize * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
