import 'dart:math';

import 'package:uuid/uuid.dart';

class AutogenerateUtil{

  String generateId() => Uuid().v4();
}