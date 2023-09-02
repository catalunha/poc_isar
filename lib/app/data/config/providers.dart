import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'state.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
class ConfigController extends _$ConfigController {
  @override
  ConfigState build() {
    return ConfigState();
  }
}
