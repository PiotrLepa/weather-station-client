import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const ProgressButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  ProgressButtonState createState() => ProgressButtonState();
}

class ProgressButtonState extends State<ProgressButton> {
  bool _progressVisible = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_progressVisible ? 'Ładowanie...' : widget.text),
          SizedBox(width: 16),
          Visibility(
            visible: _progressVisible,
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          )
        ],
      ),
    );
  }

  void show() {
    setState(() {
      _progressVisible = true;
    });
  }

  void hide() {
    setState(() {
      _progressVisible = false;
    });
  }
}
