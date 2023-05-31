import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_project/model/posts.dart';
import 'package:http/http.dart';

final calenderProvoder = ChangeNotifierProvider((ref) => CalendarProvider());

class CalendarProvider extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  set selectedDay(DateTime value) {
    _selectedDay = value;
    notifyListeners();
  }

  /// Initially TRUE
  bool _isExpanded = true;
  bool get isExpanded => _isExpanded;
  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  List<DateTime> get getWeekDates {
    int weekday = selectedDay.weekday == 7 ? 0 : selectedDay.weekday;
    DateTime start = selectedDay.subtract(Duration(days: weekday));

    final result = List.generate(7, (i) {
      return start.add(Duration(days: start.weekday + (i - 7)));
    });
    return result;
  }

  Future<List<Posts>> getPosts() async {
    try {
      final api = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      final result = await get(api);
      if (result.statusCode == 200) {
        return List.from(jsonDecode(result.body))
            .map((e) => Posts.fromJson(e))
            .toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
