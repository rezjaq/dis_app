import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisHelperFunctions {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(BuildContext context, String title, String message, Function onTap) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => onTap(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen, {Object? arguments}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => screen,
          settings: RouteSettings(
            arguments: arguments,
          )
      ),
    );
  }

  static void navigateToRoute(BuildContext context, String routeName, {Object? arguments, int initialIndex = 0}) {
    Navigator.pushNamed(context, routeName, arguments: {
      'initialIndex': initialIndex,
      ...?arguments as Map<String, dynamic>?,
    });
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)} ... ';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String getFormattedDate(DateTime dateTime, {String format = 'dd MMM yyyy HH:mm'}) {
    return DateFormat(format).format(dateTime);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}