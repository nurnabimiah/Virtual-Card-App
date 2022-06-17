
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_application/pages/scan_page.dart';

import '../custom_widgets/contact_item.dart';
import '../providers/contact_provider.dart';
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
      body:Consumer<ContactProvider>(
          builder:(context,provider,_) => ListView.builder(
            itemCount: provider.contactList.length,
            itemBuilder:(context,index){
              final contact = provider.contactList[index];
              return ContactItem(contact);

            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () {
          Navigator.pushNamed(context, ScanPage.routeName);
        },

      ),

    );

  }
}
