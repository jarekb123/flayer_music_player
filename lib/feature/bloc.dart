import 'package:flayer/di.dart';
import 'package:flayer/utils/custom_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class Bloc {
  const Bloc();

  void onError(error, StackTrace stackTrace) {
    print(this.runtimeType.toString() + ' error:');
    print(error.toString());
    print(stackTrace.toString());

    throw error;
  }

  void dispose() {}
}

B useBloc<B extends Bloc>() {
  final B bloc = useInjected<B>();

  useEffect(() {
    return bloc.dispose;
  }, [bloc]);

  return bloc;
}