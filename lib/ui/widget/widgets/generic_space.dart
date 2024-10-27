import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double spacing;
  const Gap({
    super.key,
    required this.spacing,
  });
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints contraints) {
          final parentWidget =
              context.findAncestorWidgetOfExactType<Row>() ?? context.findAncestorWidgetOfExactType<Column>();
          final isRow = parentWidget is Row;

          return SizedBox(
            width: isRow ? spacing : null,
            height: isRow ? null : spacing,
          );
        },
      );
}
