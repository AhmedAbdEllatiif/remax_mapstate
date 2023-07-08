import 'package:flutter/material.dart';

import 'ambassador_support_data.dart';

class AmbassadorSupportScreen extends StatelessWidget {
  const AmbassadorSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const AmbassadorSupportDataWidget(),
    );
  }
}
