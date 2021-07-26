import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_redux/src/models/index.dart';
import 'package:redux/redux.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key, required this.builder}) : super(key: key);

  final ViewModelBuilder<bool> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (Store<AppState> store) {
        return store.state.isLoading;
      },
      builder: builder,
    );
  }
}
