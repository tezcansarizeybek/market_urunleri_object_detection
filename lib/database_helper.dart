import 'package:sqflite/sqflite.dart';

Future<Database> veritabaniAc() async {
  var dbYol = await getDatabasesPath();
  Database db = await openDatabase('$dbYol/userDb.db', onCreate: (db, version) async {
    await db.execute(
        '''CREATE TABLE "Urunler" ("KODU"	TEXT NOT NULL,"ADI"	TEXT,"FIYAT1"	NUMERIC,"FIYAT2"	NUMERIC,"IND1"	NUMERIC,"IND2"	NUMERIC,"KDV"	NUMERIC,PRIMARY KEY("KODU"))''');
    await db.rawInsert(
        """INSERT INTO "main"."Urunler" ("KODU", "ADI", "FIYAT1", "FIYAT2", "IND1", "IND2", "KDV") VALUES ('BillurTuz', 'Billur Tuz', '4.95', '3.5', '5', '15', '8')""");
    await db.rawInsert(
        """INSERT INTO "main"."Urunler" ("KODU", "ADI", "FIYAT1", "FIYAT2", "IND1", "IND2", "KDV") VALUES ('CocaCola', 'Coca Cola', '5.9', '5.3', '17', '11', '8')""");
    await db.rawInsert(
        """INSERT INTO "main"."Urunler" ("KODU", "ADI", "FIYAT1", "FIYAT2", "IND1", "IND2", "KDV") VALUES ('WappsCikolata', 'Wapps Çikolata', '0.99', '0.75', '3', '10', '8')""");
    await db.rawInsert(
        """INSERT INTO "main"."Urunler" ("KODU", "ADI", "FIYAT1", "FIYAT2", "IND1", "IND2", "KDV") VALUES ('Kekstra', 'Kekstra Kek', '1.5', '1.25', '5', '20', '8')""");
    await db.rawInsert(
        """INSERT INTO "main"."Urunler" ("KODU", "ADI", "FIYAT1", "FIYAT2", "IND1", "IND2", "KDV") VALUES ('EtiKaram', 'Eti Karam', '2.25', '1.99', '20', '12', '8')""");
    await db.rawInsert(
        """INSERT INTO "main"."Urunler" ("KODU", "ADI", "FIYAT1", "FIYAT2", "IND1", "IND2", "KDV") VALUES ('NigdeGazozu', 'Niğde Gazozu', '8.5', '7.99', '2', '8', '8')""");
  }, version: 1);
  return db;
}
