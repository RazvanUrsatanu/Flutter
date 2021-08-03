library actions;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_redux/src/models/index.dart';

part 'get_movies.dart';

part 'index.freezed.dart';

part 'select_movie.dart';

part 'register.dart';

part 'initialize_app.dart';

part 'sign_out.dart';

part 'update_profile_url.dart';

part 'create_review.dart';

part 'get_reviews.dart';


abstract class AppAction {}

abstract class ErrorAction implements AppAction {
  Object get error;

  StackTrace get stackTrace;
}


typedef ActionResult = void Function(AppAction action);
