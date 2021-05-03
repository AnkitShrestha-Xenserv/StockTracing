import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

Widget buildTable(item) {
  return Table(
    children: [
      TableRow(
        children: [
          Tooltip(
            child: Text(buildInitials(item.companyName),
                style: TextStyle(fontSize: 20)),
            message: '${item.companyName}',
            height: 20,
            verticalOffset: 10,
            waitDuration: Duration(milliseconds: 3),
            showDuration: Duration(seconds: 5),
          ),
          Text('${item.closingPrice}', style: TextStyle(fontSize: 20)),
          Text('${item.tradedShares}', style: TextStyle(fontSize: 20)),
          Text('${item.difference}', style: TextStyle(fontSize: 20)),
        ],
        decoration: BoxDecoration(
          color: item.closingPrice - item.previousClosing > 0
              ? Colors.green
              : Colors.red,
          border: Border(
              bottom: BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          )),
        ),
      ),
    ],
  );
}

String buildInitials(String str) {
  String initials = '';
  if (!isUppercase(str)) {
    String sub;
    for (int i = 0; i < str.length; i++) {
      sub = str.substring(i, i + 1);
      if (isUppercase(sub) && isAlpha(sub)) {
        initials = initials + sub.trim();
      }
    }
  } else {
    for (int i = 0; i < str.length; i++) {
      if (str.substring(i, i + 1) == ' ') {
        if (!(str.substring(i + 1, i + 2) == '(')) {
          initials = initials + str.substring(i + 1, i + 2);
        }
      }
    }
  }
  return initials;
}
