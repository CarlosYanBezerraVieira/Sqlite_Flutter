import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseSqlite {
  // Future<Database> openConnection() async {
  Future<void> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, "SQLITE_EXAMPLE");
    print(databaseFinalPath);
    await openDatabase(
      databaseFinalPath,
      version: 2,
      onConfigure: (db) async {
        print("onConfigure sendo chamado");
        await db.execute('PRAGMA foreign_keys =  ON');
      },
      //chamado somento no momento de criação do banco de dados
      //primeira vez que carrega o app
      onCreate: (Database db, int version) {
        print("onCreate chamado");
        print(databaseFinalPath);
        final batch = db.batch();
        batch.execute('''
        create table teste(
          id Integer primary key autoincrement,
          nome varchar(200) 
          ) 
        ''');

        batch.execute('''
        create table produto(
          id Integer primary key autoincrement,
          nome varchar(200) 
          ) 
        ''');

        // batch.execute('''
        // create table categoria(
        //   id Integer primary key autoincrement,
        //   nome varchar(200)
        //   )
        // ''');
        batch.commit();
      },
//sempre será chamado sempre que ouver uma alteração no version para mais incremntal (1 -> 2)
      onUpgrade: (Database db, int oldVersion, int version) {
        print("onUpgrade chamado");
        final batch = db.batch();
        if (oldVersion == 1) {
          batch.execute('''
        create table produto(
          id Integer primary key autoincrement,
          nome varchar(200) 
          ) 
        ''');
          //   batch.execute('''
          // create table categoria(
          //   id Integer primary key autoincrement,
          //   nome varchar(200)
          //   )
          // ''');
          batch.commit();
        }
        // if (oldVersion == 2) {
        //   batch.execute('''
        // create table categoria(
        //   id Integer primary key autoincrement,
        //   nome varchar(200)
        //   )
        // ''');
        //   batch.commit();
        // }
      },

      // será chamado quando ouver uma alteração no version para menos decremental(2 -> 1)
      onDowngrade: (Database db, int oldVersion, int version) {
        print("onDowngrade chamado");
        if (oldVersion == 3) {
          final batch = db.batch();
          batch.execute('''
        drop table categoria
        ''');
        }
      },
    );

    // openDatabase(path)
  }
}
