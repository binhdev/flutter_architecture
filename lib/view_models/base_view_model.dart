import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/core/utils/network_utils.dart';


abstract class BaseViewModel extends ChangeNotifier {
  static final List<ChangeNotifier> _notifierList = [];

  bool _isEmptyListeners = false;

  late BuildContext context;

  bool hasNetworkConnection() {
    return NetworkUtils.hasConnection();
  }

  void onInitViewModel(BuildContext context) {
    this.context = context;
  }

  // Function will check size device change
  bool checkReCalculatorSize({required bool allowReCalculatorSize}) {
    return allowReCalculatorSize;
  }

  // When View build success, allow call setState().
  void onBuildComplete() {
    if (!_notifierList.contains(this)) {
      print("add [$this] notifier list");
      // 自身のインスタンス(this)を_notifierListに追加する。
      _notifierList.add(this);
    }
  }

  void updateUI() {
    print("updateUI:$runtimeType");
    // 破棄される_listenersオブジェクトの場合、状態の変化を通知しない
    if (_isEmptyListeners) return;
    // 状態の変化を通知
    notifyListeners();
    // _notifierList分のnotifyListeners()を呼び出す。
    for (ChangeNotifier notifier in _notifierList) {
      if (notifier != this) {
        print("$notifier:notifier:setState()");
        notifier.notifyListeners();
      }
    }
  }

  // Call when:
  // + dispose
  // + change screen
  void removeNotifier() {
    if (_notifierList.contains(this)) {
      print("viewModel:remove:notifier[$runtimeType]");
      // 自身のインスタンス(this)を_notifierListから削除する。
      _notifierList.remove(this);
    }
  }

  /// 破棄の処理
  @override
  void dispose() {
    print("viewModel:dispose[$runtimeType]");
    _isEmptyListeners = true;
    removeNotifier();
    super.dispose();
  }
}
