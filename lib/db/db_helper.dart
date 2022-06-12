




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
  $tblContaqctColImage text
  
  
  )''';


  static Future<Database> open() async{
    final rootPath = await getDatabasesPath();  // database ta jekhane install hobe tar root directory aita
    final dbPath = Path.join(rootPath,'contact_db');
    return openDatabase(dbPath,version: 1,onCreate: (db,version) async{
      await db. execute(_createTableContact);
    });
  }
  // insert method
  static Future<int> insertContact(ContactModel contactModel) async{
    final db = await open(); // wait korbo totho khon porjonto jothokhon na se ekta object dei
    return  db.insert(tableContact, contactModel.toMap()); // j row id ta insert hobe tar row id tai return kre dissi

  }


}