import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';

class BaseState extends ChangeNotifier {
  HttpAPI httpAPI;

  BaseState(this.httpAPI);
}
