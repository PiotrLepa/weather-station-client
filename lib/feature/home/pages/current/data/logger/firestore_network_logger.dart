import 'package:chucker_flutter/src/helpers/shared_preferences_manager.dart';
import 'package:chucker_flutter/src/models/api_response.dart';
import 'package:chucker_flutter/src/view/helper/chucker_ui_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreNetworkLogger {
  Future<void> logResponse(
    List<DocumentSnapshot<Map<String, dynamic>>> documents,
  ) async {
    await SharedPreferencesManager.getInstance().getSettings();

    if (!ChuckerFlutter.isDebugMode && !ChuckerFlutter.showOnRelease ||
        documents.isEmpty) {
      return;
    }

    final responseTime = DateTime.now();
    ChuckerUiHelper.showNotification(
      method: "GET",
      statusCode: 200,
      path: documents.first.reference.path,
      requestTime: responseTime,
    );
    await _saveResponse(documents, responseTime);
  }

  Future<void> _saveResponse(
    List<DocumentSnapshot<Map<String, dynamic>>> documents,
    DateTime responseTime,
  ) async {
    final document = documents.first;
    final jsonList = documents
        .map((e) => e.data()!)
        .map((json) => json.map((key, value) {
              try {
                final timestamp = value as Timestamp;
                final encodableTimestamp = timestamp.toDate().toString();
                return MapEntry(key, encodableTimestamp);
              } catch (_) {
                return MapEntry(key, value);
              }
            }))
        .toList();
    final body = jsonList.length > 1 ? {'data': jsonList} : jsonList.first;
    await SharedPreferencesManager.getInstance().addApiResponse(
      ApiResponse(
        body: body,
        path: document.reference.path,
        baseUrl: '',
        method: 'GET',
        statusCode: 200,
        connectionTimeout: -1,
        contentType: '',
        headers: '',
        queryParameters: '',
        receiveTimeout: -1,
        request: {},
        requestSize: -1,
        requestTime: responseTime,
        responseSize: -1,
        responseTime: responseTime,
        responseType: 'json',
        sendTimeout: -1,
        checked: false,
        clientLibrary: 'Firestore',
      ),
    );
  }
}
