

import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/contact_model.dart';

class ContactProvider with ChangeNotifier{
  List <ContactModel> _contactList = [];
  List <ContactModel> get contactList => _contactList;


  // data insert
  Future<int> insertContact(ContactModel contactModel) => DBHelper.insertContact(contactModel);

 // data get

  void getAllContacts() async
  {
    _contactList = await DBHelper.getAllContacts();
    notifyListeners();
  }

  // model update and get data from new contact page .to contactList page

  void updateList(ContactModel model){
    _contactList.add(model);
    notifyListeners();

  }

}