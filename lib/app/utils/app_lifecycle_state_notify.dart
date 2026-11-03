import 'package:clashmi/app/utils/log.dart';

class AppLifecycleStateNofity {
  static int _hashCode = 0;

  static final Map<int, void Function()> _onStateResumed = {};
  static final Map<int, void Function()> _onStateInactive = {};
  static final Map<int, void Function()> _onStatePaused = {};
  static bool _isPaused = false;

  static void init() {}
  static void uninit() {
    _onStateResumed.clear();
    _onStateInactive.clear();
    _onStatePaused.clear();
  }

  static void onStateResumed(int? hashcode, void Function()? callback) {
    if (hashcode == null) {
      if (callback != null) {
        _onStateResumed[_hashCode++] = callback;
      }
    } else {
      if (callback != null) {
        _onStateResumed[hashcode] = callback;
      } else {
        _onStateResumed.remove(hashcode);
      }
    }
  }

  static void onStateInactive(int? hashcode, void Function()? callback) {
    if (hashcode == null) {
      if (callback != null) {
        _onStateInactive[_hashCode++] = callback;
      }
    } else {
      if (callback != null) {
        _onStateInactive[hashcode] = callback;
      } else {
        _onStateInactive.remove(hashcode);
      }
    }
  }

  static void onStatePaused(int? hashcode, void Function()? callback) {
    if (hashcode == null) {
      if (callback != null) {
        _onStatePaused[_hashCode++] = callback;
      }
    } else {
      if (callback != null) {
        _onStatePaused[hashcode] = callback;
      } else {
        _onStatePaused.remove(hashcode);
      }
    }
  }

  static void stateLaunch(bool launchAtStartup) {
    if (launchAtStartup) {
      Log.d("stateLaunch:launch_at_startup");
    } else {
      Log.d("stateLaunch");
    }
  }

  static void stateResumed(String detail) {
    _isPaused = false;
    Log.d("stateResumed:$detail");

    _onStateResumed.forEach((key, value) {
      value();
    });
  }

  static void stateInactive(String detail) {
    Log.d("stateInactive:$detail");
    _onStateInactive.forEach((key, value) {
      value();
    });
  }

  static void statePaused(String detail) {
    _isPaused = true;
    Log.d("statePaused:$detail");

    _onStatePaused.forEach((key, value) {
      value();
    });
  }

  static bool isPaused() {
    return _isPaused;
  }
}
