class XCall {
  XCall._internal() {
    // 构建单例，也可直接将 _callBackMap 变为静态成员，代码简洁，但是暴露了 _callBackMap。
  }

  static final XCall _instance = XCall._internal();

  Map<String, List<Function>> _callBackMap = new Map<String, List<Function>>();

  static bool hasCallBack(String eventKey, Function callback) {
    if (_instance._callBackMap[eventKey] == null) {
      return false;
    }
    return _instance._callBackMap[eventKey].contains(callback);
  }

  static void addCallBack(String eventKey, Function callback) {
    if (_instance._callBackMap[eventKey] == null) {
      _instance._callBackMap[eventKey] = [];
    }
    if (!hasCallBack(eventKey, callback)) {
      _instance._callBackMap[eventKey].add(callback);
    }
  }

  static void removeCallBack(String eventKey, Function callback) {
    if (_instance._callBackMap[eventKey] == null) {
      return;
    }
    _instance._callBackMap[eventKey].removeWhere((callBackFunc) => callBackFunc == callback);
  }

  static void dispatch(String eventKey, {var data}) {
    if (_instance._callBackMap[eventKey] == null) {
      throw Exception('未找到回调事件 $eventKey 的监听');
    }
    _instance._callBackMap[eventKey].forEach((callBackFunc) {
      callBackFunc?.call(data);
    });
  }
}
