import 'package:flutter/material.dart';
import 'package:sqlite_flutter/database/database_sqlite.dart';
import 'package:sqlite_flutter/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>?> _database({required Taskmodel? task}) async {
    print("tento salvar");
    var database = await DatabaseSqlite().openConnection();
    // database.insert('produto', {'nome': 'Carlos Yan'});
    // database.delete('produto', where: 'id = ?', whereArgs: ['4']);
    // database.update('produto', {'nome':'Carlos'}, where: 'id = ?',  whereArgs:  ['1']);
    // var result =await database.query('produto');
    // print(result);

    // database.rawInsert('insert into produto values(null, ?)',['Carlos Yan com raw']);
    // database.rawUpdate('update produto set nome = ? where id = ?',['Carlos Yan com raw update', 5]);
    // database.rawDelete('delete from produto where id = ?',[5]);
    // var result = await database.rawQuery('select * from Task');

    if (task != null) {
      // database.insert('Task', {
      //   'title': task.title,
      //   'datatime': task.datetime,
      //   'time': task.time,
      //   'description': task.description,
      //   'value': task.value
      // });
      // database.delete('Task', where: 'id = ?', whereArgs: [1]);
      var result = await database.query('Task');
      print(result);
      // return result;
    }
  }

  chama() {
    print("chamo");
    final task = Taskmodel(
        title: "Primeira Task no Banco de dados",
        datetime: 0,
        time: "hoje",
        description: "primeiro teste",
        value: 1);

    _database(task: task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            child: Text("Salvar task"),
            onPressed: chama,
          ),
        ),
      ),
    );
  }
}
