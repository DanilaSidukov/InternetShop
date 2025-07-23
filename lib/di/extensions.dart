
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app.dart';

extension Provide on BuildContext {
  App get provider => read<App>();
}
