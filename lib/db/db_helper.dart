




import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import '../models/contact_model.dart';


class DBHelper{

  static final String _createTableContact = '''create table $tableContact(
  $tblContactColId integer primary key autoincrement,
  $tblContaqctColName text,
  $tblContaqctColMobile text,
  $tblContaqctColEmail text,
  $tblContaqctColAddress text,
  $tblContaqctColCompany text,
  $tblContaqctColDesignation text,
  $tblContaqctColWebsite text,
  $tblContaqctColImage text,
  $tblContaqctColFavorite integer
  
  
  )''';


  static Future<Database> open() async{
    final rootPath = await getDatabasesPath();  // database ta jekhane install hobe tar root directory aita
    final dbPath = Path.join(rootPath,'contact_db');
    return openDatabase(dbPath,version: 2,onCreate: (db,version) async{
      await db. execute(_createTableContact);
    }, onUpgrade: (db, oldversion,newVersion) async{
      if (oldversion == 1){
        db.execute('alter table $tableContact add column $tblContaqctColFavorite integer not null defalult 0');
      }

    });
  }
  // insert method
  static Future<int> insertContact(ContactModel contactModel) async{
    final db = await open(); // wait korbo totho khon porjonto jothokhon na se ekta object dei
    return  db.insert(tableContact, contactModel.toMap()); // j row id ta insert hobe tar row id tai return kre dissi

  }

  // get contacts list

  static Future<List<ContactModel>> getAllContacts() async{
    final db = await open();
    final List<Map<String,dynamic>> mapList = await db.query(tableContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index])); //loop chalaisi,generate method ta kaj korse
  }
// details page ja jan niye jassi
  static Future<ContactModel> getContactByID(int id) async{
    final db = await open();
    final List<Map<String,dynamic>> mapList = await db.query(tableContact,where: '$tblContactColId = ?',whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }


  // delete or dismissible widget

  static Future<int> deleteContactByID(int id) async{ // j row ta delete holo tar row id ta return krbe
    final db = await open();
    return db.delete(tableContact,where: '$tblContactColId = ?',whereArgs: [id]);
    
  }

  // update for favorite

  static Future<int> updateContactFavoriteById(int id,int value) async{
    final db = await open();
    return db.update(tableContact,{tblContaqctColFavorite:value},where: '$tblContactColId = ?',whereArgs: [id]);

  }




}



/*ai DBHelper er under a kiso static method thakbe , method golo use kre amra
 insert,update,delate ai query golo use korte parbo

 */


/*function ta hobe future data base ja ekta sqlite er object,jokhoni amar kono database operation
 krte hobe like insert update delete tokhon open() diye amader database ta k open krte hobe,
  first of all ai database ta jekhane  create hobe er path ta amak bole dite hobe*/