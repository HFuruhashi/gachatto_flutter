import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  get value => _count;

  void increment() {
    _count++;
    notifyListeners(); // ウィジェットに変更を通知
  }

  void decrement() {
    _count--;
    notifyListeners(); // ウィジェットに変更を通知
  }
}