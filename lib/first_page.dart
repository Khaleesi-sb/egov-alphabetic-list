import 'package:egov_proj_dropdown/widgets/alphabeticSearchList.dart';
import 'package:flutter/material.dart';

import 'country_data.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('EGOV'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const WidgetPage()),
        //         );
        //       },
        //       icon: const Icon(Icons.ac_unit)
        //   )
        // ],
      ),
      body: Center(
        child: AlphabetScroll(items: countriesData,),
      ),
    );
  }
}
