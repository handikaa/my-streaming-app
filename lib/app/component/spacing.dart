import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Cache untuk menyimpan instance SizedBox vertikal & horizontal
final Map<int, SizedBox> _verticalCache = {};
final Map<int, SizedBox> _horizontalCache = {};

/// Memberi jarak vertikal responsif
SizedBox verticalSpace(double height) {
  final key = (height * 1000).toInt(); // Hindari key dari double langsung
  if (!_verticalCache.containsKey(key)) {
    _verticalCache[key] = SizedBox(height: height.h);
  }
  return _verticalCache[key]!;
}

/// Memberi jarak horizontal responsif
SizedBox horizontalSpace(double width) {
  final key = (width * 1000).toInt(); // Hindari key dari double langsung
  if (!_horizontalCache.containsKey(key)) {
    _horizontalCache[key] = SizedBox(width: width.w);
  }
  return _horizontalCache[key]!;
}
