

import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/contact_model.dart';

class ContactProvider with ChangeNotifier{
  List <ContactModel> _contactList = [];
  List <ContactModel> get contactList => _contactList;


  // data insert
  Future<int> insertContact(ContactModel contactModel) => DBHelper.insertContact(contactModel);





}