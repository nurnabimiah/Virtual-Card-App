
import 'package:flutter/material.dart';

import 'new_contact_pages.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';


  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Contact List') ,
      ),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () {
          Navigator.pushNamed(context, NewContactPage.routeName);
        },

      ),

    );

  }
}
