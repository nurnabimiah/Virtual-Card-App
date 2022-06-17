

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


  void removeItemFromList(ContactModel model){
    _contactList.remove(model);
    notifyListeners();

  }


  // contact delete or dismis

Future<int> deleteContact (int id ){
 return DBHelper.deleteContactByID(id);
  
}

// contact favourite update
void updateContactFavouriteById(int id, int value){
   DBHelper.updateContactFavoriteById(id, value).then((value) {
      final contact =  _contactList.firstWhere((element) => element.id==id);
      final index = _contactList.indexOf(contact);
      _contactList[index].favortite = !_contactList[index].favortite;
      notifyListeners();
     /*aikhane kaj ta ja korlam ta holo list view nije k refresh kortase, beparta akhon listview er gare chapai disi
   listview j list ta  show kortase, sei list er kono ekta item change hyse, listview k bollam tmi j contact gola show
   kortaseo,sei contacList er kotho tomo index a favorite er j value ta ase ta change hyse, so tmi nije k notify koro

    */
   });


}



}