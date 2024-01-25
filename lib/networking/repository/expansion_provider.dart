import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_models/expansion_notifier.dart';

final expansionStateProvider = StateNotifierProvider<ExpansionStateNotifier, bool>((ref) {
  return ExpansionStateNotifier();
});
final expansionStateProvider1 = StateNotifierProvider<ExpansionStateNotifier, bool>((ref) {
  return ExpansionStateNotifier();
});

final expansionpriceStateProvider = StateNotifierProvider<ExpansionStateNotifier, bool>((ref) {
  return ExpansionStateNotifier();
});