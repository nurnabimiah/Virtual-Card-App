

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card_application/providers/contact_provider.dart';

import '../models/contact_model.dart';
import '../pages/contact_details page.dart';

class ContactItem extends StatefulWidget {
  final ContactModel contactModel;
  ContactItem(this.contactModel);

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      /*ai dismissible widget akta key nei ja protita item a bose se item golo k swaip kore delet kre*/
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: 20),
       color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete,color: Colors.white,size: 40,),

      ),
      confirmDismiss: showConfirmationDialog,
      /*onDismissed method ta tokhoni call hoy jodi aita true return kore*/
      onDismissed:(_){
        Provider.of<ContactProvider>(context,listen: false).deleteContact(widget.contactModel.id);

      },

      child: Card(
        color: Colors.grey,
        elevation: 5,
        child: ListTile(
          onTap: (){
            Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: [widget.contactModel.id,widget.contactModel.name] );

          },
          contentPadding: const EdgeInsets.symmetric(horizontal:12,vertical:8 ),
          title: Text(widget.contactModel.name),
          subtitle:Text(widget.contactModel.mobile) ,
          trailing: IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: (){

            },
          ),

        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(DismissDirection direction)
  {

    return showDialog(context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Contact'),
          content: const Text('Sure to Delete this contact'),
          actions: [
            TextButton( child: const Text('CANCEL'),
            onPressed: (){
              Navigator.pop(context,false);

            },
            ),

            ElevatedButton(
              child: const Text('YES'),
              onPressed: (){
                Navigator.pop(context,true);
              },
            ),
          ],
        ));

  }
}
