import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:one_store_delivery/core/utils/ansi_color.dart';

class MyBlocObserver extends BlocObserver {
  final Map<BlocBase, Stopwatch> _executionTimers = {};

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log(
      AnsiColor.colorize(
        "'onCreate -- ${bloc.runtimeType}'",
        AnsiColor.brightRed,
      ),
      name: "Bloc Observer",
    );
    startExecutionTimer(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      AnsiColor.colorize(
        'onEvent -- ${bloc.runtimeType}, Event: $event',
        AnsiColor.yellow,
      ),
      name: "Bloc Observer",
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(
      AnsiColor.colorize(
        'onChange -- ${bloc.runtimeType}, $change',
        AnsiColor.brightCyan,
      ),
      name: "Bloc Observer",
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      AnsiColor.colorize(
        'onTransition -- ${bloc.runtimeType}, Transition: $transition',
        AnsiColor.reset,
      ),
      name: "Bloc Observer",
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      AnsiColor.colorize(
        'onError -- ${bloc.runtimeType}, Error: $error, StackTrace: $stackTrace',
        AnsiColor.red,
      ),
      name: "Bloc Observer",
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    _executionTimers[bloc]?.stop();
    if (_executionTimers.containsKey(bloc)) {
      final duration = _executionTimers[bloc]!.elapsed;
      log(
        AnsiColor.colorize(
          'onClose -- ${bloc.runtimeType}, Total Active Duration: $duration',
          AnsiColor.bgBrightWhite,
        ),
        name: "Bloc Observer",
      );

      _executionTimers.remove(bloc);
    }
    super.onClose(bloc);
    log(
      AnsiColor.colorize(
        'onClose -- ${bloc.runtimeType}',
        AnsiColor.bgBrightWhite,
      ),
      name: "Bloc Observer",
    );
  }

  void startExecutionTimer(BlocBase bloc) {
    _executionTimers[bloc] = Stopwatch()..start();
    log(
      AnsiColor.colorize(
        'Execution Timer started for -- ${bloc.runtimeType}',
        AnsiColor.bgGreen,
      ),
      name: "Bloc Observer",
    );
  }

  void stopExecutionTimer(BlocBase bloc) {
    if (_executionTimers.containsKey(bloc)) {
      _executionTimers[bloc]?.stop();
      final duration = _executionTimers[bloc]!.elapsed;
      log(
        AnsiColor.colorize(
          'Execution Timer started for -- ${bloc.runtimeType}, Duration: $duration',
          AnsiColor.brightMagenta,
        ),
        name: "Bloc Observer",
      );
    }
  }
}
