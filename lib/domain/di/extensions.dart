
import 'package:flutter/cupertino.dart';
import 'package:internet_shop/domain/di/app.dart';
import 'package:provider/provider.dart';

extension Provide on BuildContext {
  App get provider => Provider.of<App>(this, listen: false);
}
