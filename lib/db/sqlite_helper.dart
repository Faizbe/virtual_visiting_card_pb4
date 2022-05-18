import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:virtual_visiting_card_pb4/model/contact_model.dart';

class DBHelper {
  static const _createTableContact = '''create table $tblContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text,
  $tblContactColCompanyName text,
  $tblContactColDesignation text,
  $tblContactColAddress text,
  $tblContactColMobile text,
  $tblContactColEmail text,
  $tblContactColWebsite text,
  $tblContactColFavorite integer)''';

  static Future<Database> open() async {
    final root = await getDatabasesPath();
    final dbPath = Path.join(root, 'contact.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(_createTableContact);
    });
  }

  static Future<int> insertContact(ContactModel contactModel) async {
    final db = await open();
    return db.insert(tblContact, contactModel.toMap());
  }

  static Future<List<ContactModel>> getAllContacts() async {
    final db = await open();
    final mapList = await db.query(tblContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<ContactModel> getContactById(int id) async {
    final db = await open();
    final mapList = await db.query(tblContact, where: '$tblContactColId = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }

  static Future<int> updateContactFavorite(int id, int value) async {
    final db = await open();
    return db.update(tblContact, {tblContactColFavorite : value}, where: '$tblContactColId = ?', whereArgs: [id]);
  }

  static Future<int> deleteContact(int id) async {
    final db = await open();
    return db.delete(tblContact, where: '$tblContactColId = ?', whereArgs: [id]);
  }
}