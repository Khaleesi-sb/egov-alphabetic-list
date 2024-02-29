import 'package:egov_proj_dropdown/widgets/alphabeticSearchList.dart';
import 'package:flutter/material.dart';
import 'country_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          title: const Text('EGOV'),
          centerTitle: true,
        ),
        body: Center(
          child: AlphabetScroll(items: countriesData,),
        ),
      ),
    );
  }
}


