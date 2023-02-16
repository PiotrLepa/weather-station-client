import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class FirebaseTimestampJsonConverter
    implements JsonConverter<Timestamp, Timestamp> {
  const FirebaseTimestampJsonConverter();

  @override
  Timestamp fromJson(Timestamp json) => json;

  @override
  Timestamp toJson(Timestamp object) => object;
}
