

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_application/pages/contact_details%20page.dart';
import 'package:virtual_card_application/pages/contact_list_page.dart';
import 'package:virtual_card_application/pages/new_contact_pages.dart';
import 'package:virtual_card_application/pages/scan_page.dart';
import 'package:virtual_card_application/providers/contact_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=>ContactProvider(),

      child: MyApp()));
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName:  (context)=> ContactListPage(),
        ContactDetailsPage.routeName: (context) => ContactDetailsPage(),
        NewContactPage.routeName: (context) => NewContactPage(),
        ScanPage.routeName: (context) => ScanPage(),

      },

    );
  }
}
