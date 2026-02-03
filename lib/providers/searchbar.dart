import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  void clear() {
    controller.clear();
    notifyListeners();
  }

  void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
