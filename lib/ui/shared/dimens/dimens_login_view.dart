import 'package:flutter_architecture_sample/ui/shared/dimens/base_dimens.dart';

class DimensLoginView extends BaseDimens {

  double logoSize = 0.0;
  // TODO: Add more size

  @override
  void initialDimens<LoginView>() {
    logoSize = fullHeightSafeArea * 0.2;
  }
}
