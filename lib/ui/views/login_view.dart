import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture_sample/core/enums/enums.dart';
import 'package:flutter_architecture_sample/core/l10n/strings.dart';
import 'package:flutter_architecture_sample/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:flutter_architecture_sample/ui/shared/colors.dart';
import 'package:flutter_architecture_sample/ui/shared/dimens/dimens_login_view.dart';
import 'package:flutter_architecture_sample/ui/shared/dimens/dimens_manager.dart';
import 'package:flutter_architecture_sample/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with WidgetsBindingObserver {
  late LoginViewModel _loginViewModel;
  bool _isChangeMetrics = false;
  final DimensLoginView _viewSize = DimensManager().loginViewSize;

  final _kHintTextStyle = const TextStyle(
    color: Colors.grey,
    // fontFamily: Fonts.nameFont,
    fontWeight: FontWeight.bold,
  );

  final _kWarmLabelStyle = TextStyle(
    // color: HexColors.warningColor,
    fontWeight: FontWeight.bold,
    // fontFamily: Fonts.nameFont,
  );

  final _kLabelStyle = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    _initViewModel();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => _onBuildCompleted());
  }

  void _initViewModel() {
    _loginViewModel = LoginViewModel();
    _loginViewModel.onInitViewModel(context);
  }

  void _onBuildCompleted() {
    _loginViewModel.onBuildComplete();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => _loginViewModel,
      child: Selector<LoginViewModel, bool>(
        // When size change selector here will check and re-calculator size
        selector: (_, viewModel) => viewModel.checkReCalculatorSize(
            allowReCalculatorSize:
                _viewSize.checkAllowReCalculatorSize(context)),
        builder: (_, calculatorSize, __) {
          if (calculatorSize) {
            // If size device change will re-calculator size
            _viewSize.calculatorRatio<LoginView>(context);
          }
          return Scaffold(
            backgroundColor: HexColors.black,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    // Column(
                    //   children: [
                    //     Container(
                    //       height: _viewSize.contentHeight,
                    //       alignment: Alignment.center,
                    //       child: _buildContent(),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: _viewSize.fullHeight,
                      child: _buildLoading(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildErrorMessageWhenLogin(LoginValidateError loginValidateError) {
    String? textError;
    switch (loginValidateError) {
      case LoginValidateError.userIdNull:
        // textError = Strings.of(context)!.userId;
        break;
      case LoginValidateError.passwordNull:
      // textError = Strings.of(context)!.password;
        break;
      case LoginValidateError.unauthorized:
      // textError = Strings.of(context)!.userIdPasswordNotMatch;
        break;
      case LoginValidateError.noInternet:
      //   textError = Strings.of(context)!.noInternet;
        break;
      case LoginValidateError.none:
        textError = null;
        break;
    }
    return textError != null
        ? Text(
            textError,
            // style: _kWarmLabelStyle.copyWith(
            //   fontSize: _viewSize.textErrorFontSize,
            // ),
          )
        : Container();
  }

  Widget _buildLoginBtn() {
    return SizedBox(
      // width: _viewSize.buttonLoginWidth,
      // height: _viewSize.buttonLoginHeight,
      child: ElevatedButton(
        // style: ElevatedButton.styleFrom(
        //   // colors
        //   primary: HexColors.buttonLoginColor,
        //   // background
        //   alignment: Alignment.center,
        //   onPrimary: HexColors.white,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(30.0),
        //     side: BorderSide(
        //       color: HexColors.buttonStrokeLoginColor,
        //     ),
        //   ),
        //   elevation: 5.0,
        // ),
        onPressed: () {
          _loginViewModel.onPressLogin(
            onSuccess: (message) {
              _loginViewModel.removeNotifier();
              // TopScreenNavigatorRoutes().openMainView(context);
            },
          );

        },
        child: Text(
          "Login", // Strings.of(context)!.login,
          textAlign: TextAlign.center,
          // style: TextStyle(
          //   color: HexColors.white,
          //   letterSpacing: 1.5,
          //   fontSize: _viewSize.buttonLoginFontSize,
          //   fontWeight: FontWeight.bold,
          //   fontFamily: Fonts.notoSansJPMedium,
          // ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Selector<LoginViewModel, bool>(
      // When size change selector here will check and re-calculator size
      selector: (_, viewModel) => viewModel.isShowLoading,
      builder: (_, isShowLoading, __) {
        return isShowLoading ? Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent),
          ),
        ) : Container();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    print("ChangeMetrics");
    _isChangeMetrics = true;
    _loginViewModel.updateUI();
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    print("ChangeTextScale");
    if (!_isChangeMetrics) {
      _loginViewModel.updateUI();
    }
    _isChangeMetrics = false;
  }

  @override
  void dispose() {
    print("$runtimeType disposed !!!");
    super.dispose();
    _loginViewModel.userIdTextFieldController.dispose();
    _loginViewModel.passwordIdTextFieldController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
