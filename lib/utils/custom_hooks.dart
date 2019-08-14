import 'package:flayer/di.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

export 'package:flutter_hooks/flutter_hooks.dart';

T useProvider<T>() {
  final context = useContext();

  return Provider.of<T>(context);
}

T useInjected<T>() => useMemoized(() => inject<T>());
