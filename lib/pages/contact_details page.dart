

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';
import '../providers/contact_provider.dart';

class ContactDetailsPage extends StatelessWidget {
  static const String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List; // receive the collection
    final id = argList[0];
    final name = argList [1];
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Center(
          child: Consumer<ContactProvider>(
            builder:(context,provider,_) =>FutureBuilder<ContactModel>(
              future: provider.getContactById(id),

              builder: (context,snapshot) {
                if(snapshot.hasData){
                  final contact = snapshot.data;
                  return buildDetailsListBody(contact);
                }
                if(snapshot.hasError){
                  return const Text('Failed to fetch data');
                }

                return CircularProgressIndicator();

              },
            ),
          ),
        )
    );

  }

  ListView buildDetailsListBody(ContactModel? contact) {
    return ListView(
                  padding: const EdgeInsets.all(12.0),
                  children: [
                    Image.network( contact!.image,width: double.infinity,height: 250,fit:BoxFit.cover ,),
                    ListTile(
                      title:Text(contact.mobile) ,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed:() {},
                              icon: Icon(Icons.call)),
                          IconButton(onPressed:() {},
                              icon: Icon(Icons.sms)),


                        ],

                      ) ,
                    ),


                    ListTile(
                      title:Text(contact.email) ,
                      trailing:
                      IconButton(onPressed:() {},
                          icon: Icon(Icons.email)),


                    ),


                    ListTile(
                      title:Text(contact.address) ,
                      trailing:
                      IconButton(onPressed:() {},
                          icon: Icon(Icons.map)),


                    ),



                    ListTile(
                      title:Text(contact.website) ,
                      trailing:
                      IconButton(onPressed:() {},
                          icon: Icon(Icons.web)),


                    ),




                  ],

                );
  }
}
