import 'package:flutter/material.dart';

double responsiveValue(BuildContext context, double small, double large, {double breakpoint = 600}) {
  final width = MediaQuery.of(context).size.width;
  return width < breakpoint ? small : large;
} 