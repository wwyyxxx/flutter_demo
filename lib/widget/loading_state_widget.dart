import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/color.dart';
import '../config/string.dart';

enum ViewState { loading, done, error }

class LoadingStateWidget extends StatelessWidget {

  final ViewState viewState;
  late VoidCallback? retry;
  late Widget? child;

  LoadingStateWidget(
      {required Key key, this.viewState = ViewState.loading, this.retry, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) return _loadView;
    else if (viewState == ViewState.error) return _errorView;
    else return child!;
  }

  Widget get _errorView {
    return Center(
      // 类似LinearLayout
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/ic_error.png',
            width: 100,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              WyxString.net_request_fail,
              style: TextStyle(color: WyxColor.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: retry,
              child: Text(
                WyxString.reload_again,
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
            ),
          )
        ],
      ),
    );
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
