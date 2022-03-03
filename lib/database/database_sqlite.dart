import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqlite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, "SQLITE_EXAMPLE");
    print(databaseFinalPath);
    return await openDatabase(
      databaseFinalPath,
      version: 6,
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
        // batch.execute('''
        // create table teste(
        //   id Integer primary key autoincrement,
        //   nome varchar(200)
        //   )
        // ''');

        batch.execute('''
        create table produto(
          id Integer primary key autoincrement,
          nome varchar(200) 
          ) 
        ''');

        batch.execute('''
        create table Task(
          id Integer primary key autoincrement,
          title text,
          datatime num,
          time varchar(100),
          description text,
          value integer
          ) 
        ''');

        batch.commit();
      },
//sempre será chamado sempre que ouver uma alteração no version para mais incremntal (1 -> 2)
      onUpgrade: (Database db, int oldVersion, int version) {
        print("onUpgrade chamado");
        final batch = db.batch();

        if (oldVersion == 5) {
          batch.execute('''
        create table Task(
          id Integer primary key autoincrement,
          title text,
          datatime num,
          time varchar(100),
          description text,
          value num
          )
        ''');
          batch.commit();
        }
      },

      // será chamado quando ouver uma alteração no version para menos decremental(2 -> 1)
      onDowngrade: (Database db, int oldVersion, int version) {
        print("onDowngrade chamado");
        if (oldVersion == 5) {
          final batch = db.batch();
          batch.execute('''
        drop table Task
        ''');
        }
      },
    );
  }
}
