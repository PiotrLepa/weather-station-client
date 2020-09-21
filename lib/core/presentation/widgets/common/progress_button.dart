import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color progressColor;
  final bool showRefreshAutomatically;
  final VoidCallback onPressed;

  const ProgressButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.textStyle,
    this.progressColor,
    this.backgroundColor,
    this.showRefreshAutomatically = false,
  }) : super(key: key);

  @override
  ProgressButtonState createState() => ProgressButtonState();
}

class ProgressButtonState extends State<ProgressButton> {
  bool _progressVisible = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (!_progressVisible) {
          if (widget.showRefreshAutomatically) {
            show();
          }
          widget.onPressed();
        }
      },
      color:
          widget.backgroundColor ?? Theme.of(context).buttonTheme.colorScheme,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16),
          Text(
            _progressVisible ? 'Ładowanie...' : widget.text,
            style: widget.textStyle,
          ),
          SizedBox(width: 16),
          Visibility(
            visible: _progressVisible,
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProgressColor(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getProgressColor() {
    if (widget.backgroundColor == null) {
      return widget.progressColor ?? widget.textStyle?.color ?? Colors.white;
    } else {
      return widget.progressColor ??
          widget.textStyle?.color; // else default progress color
    }
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
