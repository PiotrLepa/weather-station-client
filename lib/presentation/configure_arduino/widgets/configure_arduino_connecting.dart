import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/loading_images_provider.dart';
import 'package:weather_station/gen/assets.gen.dart';

class ConfigureArduinoConnecting extends StatefulWidget {
  @override
  _ConfigureArduinoConnectingState createState() =>
      _ConfigureArduinoConnectingState();
}

class _ConfigureArduinoConnectingState
    extends State<ConfigureArduinoConnecting> {
  final _imagesProvider = getIt<LoadingImagesProvider>();

  SvgGenImage _image;
  Timer _timer;

  _ConfigureArduinoConnectingState() {
    _image = _imagesProvider.getNext();
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _image = _imagesProvider.getNext();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    return super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width - 100;
    return SizedBox.expand(
      child: Column(
        children: [
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: Text(
              Strings.arduinoWifiConnectingWithDevice.get(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: scaleText(20),
              ),
            ),
          ),
          const SizedBox(height: 64),
          _image.svg(
            width: imageSize,
            height: imageSize,
          ),
        ],
      ),
    );
  }
}
