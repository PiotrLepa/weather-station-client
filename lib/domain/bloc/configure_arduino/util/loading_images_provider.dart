import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/gen/assets.gen.dart';

@lazySingleton
class LoadingImagesProvider {
  final _loadingImages = KtList.of(
    Assets.images.signalSearching0,
    Assets.images.signalSearching1,
    Assets.images.signalSearching2,
    Assets.images.signalSearching3,
  );

  var _nextIndex = 0;

  SvgGenImage getNext() {
    final image = _loadingImages[_nextIndex];
    _nextIndex++;
    if (_nextIndex >= _loadingImages.size) {
      _nextIndex = 0;
    }
    return image;
  }
}
