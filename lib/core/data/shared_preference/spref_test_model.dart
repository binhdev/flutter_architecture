
import 'package:flutter_architecture_sample/core/data/shared_preference/spref_base_model.dart';

class SPrefTestModel extends SPrefBaseModel {
  static const String keyTest = "KEY_TEST"; // TODO : add more key or create more SPrefModel

  static SPrefTestModel? _instance;

  SPrefTestModel._();

  factory SPrefTestModel() => _instance ??= SPrefTestModel._();

  void destroyInstance() {
    _instance = null;
  }

  Future<bool> setSaveValue(int id) {
    return setInt(key: keyTest, value: id);
  }

  int getSaveValue({int defaultValue = 0}) {
    return getInt(key: keyTest, defaultValue: 0);
  }
}
