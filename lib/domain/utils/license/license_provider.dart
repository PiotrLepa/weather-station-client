import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/license/license.dart';
import 'package:weather_station/gen/assets.gen.dart';

@lazySingleton
class LicenseProvider {
  Future<KtList<License>> getPackagesLicenses() async {
    final jsonString = await rootBundle.loadString(Assets.json.packagesLicense);
    final json = jsonDecode(jsonString) as Iterable;
    return json.kt.map(_decodeLicense);
  }

  License _decodeLicense(dynamic item) {
    return License.fromJson(item as Map<String, dynamic>);
  }
}
