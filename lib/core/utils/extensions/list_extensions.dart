import 'package:flutter/material.dart';

extension ListExtensions<T> on List<T> {
  void addToFirst(T element) {
    insert(0, element);
  }
}
