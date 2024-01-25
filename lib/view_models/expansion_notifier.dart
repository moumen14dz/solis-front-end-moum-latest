import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpansionStateNotifier extends StateNotifier<bool> {
  ExpansionStateNotifier() : super(false);

  void toggle() {
    state = !state;
  }

  void toggle1() {
    state = !state;
  }
}
