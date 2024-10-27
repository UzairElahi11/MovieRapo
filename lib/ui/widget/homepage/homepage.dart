import 'package:flutter/material.dart';
import 'package:testmovie/ui/widget/widgets/base/base_widget.dart';
import 'package:testmovie/ui/widget/widgets/generic_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWidget(
      child: GenericContainer(),
    );
  }
}