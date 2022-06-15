

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
  // add korar pore update list

  void updateList(ContactModel model){
    _contactList.add(model);
    notifyListeners();

  }


  // provider database thekhe jeita pabe ContactModel direct ta return kore dibe
  // for contact details page
  Future<ContactModel> getContactById (int id) => DBHelper.getContactByID(id);


  // contact delete or dismis

void deleteContact (int id ){
  DBHelper.deleteContactByID(id);
  
}

// contact favourite update
Future<int> updateContactFavouriteById(int id, int value){
  return DBHelper.updateContactFavoriteById(id, value);
}



}