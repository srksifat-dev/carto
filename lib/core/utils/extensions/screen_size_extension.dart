import 'package:flutter/widgets.dart';

extension ScreenSize on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height / 100;
  double get screenWidth => MediaQuery.of(this).size.width / 100;
  double get screenPaddingTop => MediaQuery.of(this).padding.top / 100;
  double get screenPaddingBottom => MediaQuery.of(this).padding.bottom / 100;
  double get screenPaddingLeft => MediaQuery.of(this).padding.left / 100;
  double get screenPaddingRight => MediaQuery.of(this).padding.right / 100;
}
