

import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import '../pages/contact_details page.dart';

class ContactItem extends StatelessWidget {
  final ContactModel contactModel;
  ContactItem(this.contactModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 5,
      child: ListTile(
        onTap: (){
          Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: [contactModel.id,contactModel.name] );

        },
        contentPadding: const EdgeInsets.symmetric(horizontal:12,vertical:8 ),
        title: Text(contactModel.name),
        subtitle:Text(contactModel.mobile) ,
        trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: (){

          },
        ),

      ),
    );
  }
}
