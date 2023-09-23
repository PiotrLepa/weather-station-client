import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:network_logger/network_logger.dart';
import 'package:network_logger/src/network_event.dart';

@injectable
class FirestoreNetworkLogger {
  final logger = NetworkLogger.instance;

  void logResponse({
    required String path,
    required List<DocumentSnapshot<Map<String, dynamic>>> documents,
  }) {
    logger.add(NetworkEvent.now(
      request: Request(
        method: "GET",
        uri: path,
        headers: Headers([]),
      ),
      response: Response(
        statusCode: documents.isEmpty ? 500 : 200,
        headers: Headers([]),
        statusMessage: "",
        data: getResponseJson(documents),
      ),
    ));
  }

  dynamic getResponseJson(
    List<DocumentSnapshot<Map<String, dynamic>>> documents,
  ) {
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
    return jsonList.length == 1 ? jsonList.first : jsonList;
  }
}
