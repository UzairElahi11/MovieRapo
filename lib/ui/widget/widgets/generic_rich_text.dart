import 'package:flutter/material.dart';

class GenericRichText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final List<InlineSpan> children;
  final bool button;

  const GenericRichText({
    Key? key,
    required this.text,
    this.textStyle = const TextStyle(),
    this.button = false,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: textStyle,
        children: children,
      ),
    );
  }
}
