import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:html/dom.dart' as dom;

class LicenseItem extends StatelessWidget {
  final String name;
  final void Function(String url) onLinkClicked;

  const LicenseItem({
    Key? key,
    required this.name,
    required this.onLinkClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Html(
        data: name,
        onLinkTap: (
          String? url,
          RenderContext context,
          Map<String, String> attributes,
          dom.Element? element,
        ) {
          if (url != null) {
            onLinkClicked(url);
          }
        },
        style: {
          'html': Style(
            fontSize: FontSize.large,
            fontWeight: FontWeight.w500,
          ),
        },
      ),
    );
  }
}
