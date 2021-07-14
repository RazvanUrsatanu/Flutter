library current;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:weather_app/src/models/serializers.dart';

part 'current.g.dart';

abstract class Current implements Built<Current, CurrentBuilder> {
  factory Current([void Function(CurrentBuilder b) updates]) = _$Current;

  factory Current.fromJson(dynamic json) => serializers.deserializeWith(serializer, json)!;

  Current._();

  double get temp;

  double get celsius => temp - 273.15;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  static Serializer<Current> get serializer => _$currentSerializer;
}
