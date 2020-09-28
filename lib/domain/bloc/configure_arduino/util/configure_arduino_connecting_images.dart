import 'package:kt_dart/collection.dart';
import 'package:weather_station/gen/assets.gen.dart';

final _connectingImages = KtList.of(
  Assets.images.signalSearching0,
  Assets.images.signalSearching1,
  Assets.images.signalSearching2,
  Assets.images.signalSearching3,
);

var _nextIndex = 0;

SvgGenImage getNextImage() {
  final image = _connectingImages[_nextIndex];
  _nextIndex++;
  if (_nextIndex >= _connectingImages.size - 1) {
    _nextIndex = 0;
  }
  return image;
}
