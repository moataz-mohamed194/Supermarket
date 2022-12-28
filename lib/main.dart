import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supermarket/test/Desktop.dart';
import 'core/StrogeData/hive.dart';
import 'domain/ExpensesAndProfitProvider.dart';
import 'domain/ExpensesProvider.dart';
import 'domain/NotesProvider.dart';
import 'domain/ProductDataTextFieldProvider.dart';
import 'domain/ProfitProvider.dart';
import 'domain/RegistrationTextFieldProvider.dart';
import 'domain/SearchTextFieldProvider.dart';
import 'screens/MainScreen/MainPageOfBanks.dart';
import 'screens/Registration/login.dart';
import 'package:path/path.dart';
import 'package:hive_flutter/adapters.dart';

import 'test2/MyApp2.dart';


Future<Database> initializedDB() async {
  String path = await getDatabasesPath();
  return openDatabase(
    join(path, 'market3.db'),
    version: 4,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE Note (id INTEGER PRIMARY KEY , title TEXT, content TEXT )',
      );
      await db.execute(
        'CREATE TABLE Costs (id INTEGER PRIMARY KEY , price DECIMAL, content TEXT, dateOfAction DATETIME )',
      );

      await db.execute(
        'CREATE TABLE profit (id INTEGER PRIMARY KEY , price DECIMAL, content TEXT, count INTEGER, dateOfAction DATETIME )',
      );
      await db.execute(
        'CREATE TABLE Products (id INTEGER PRIMARY KEY , name TEXT, count INTEGER, price DECIMAL, note TEXT, code TEXT, qrCode TEXT )',
      );
      return await db.execute(
        'CREATE TABLE User(id INTEGER PRIMARY KEY , name TEXT, email TEXT UNIQUE, password TEXT)',
      );
    },
  );
}
Future<void> main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  var tasksBox = await Hive.openBox<Person>('user');
  Person? loggedData = tasksBox.get(0);
  await initializedDB();
  runApp( MyApp(loggedData: loggedData,));

}

class MyApp extends StatelessWidget {
  final Person? loggedData;

  const MyApp({super.key, this.loggedData});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationTextFieldProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchTextFieldProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDataTextFieldProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpensesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfitProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpensesAndProfitProvider(),
        ),
      ],
      child: MaterialApp(
            title: 'Banking',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:MyApp2()
        //home:loggedData==null||loggedData!.logged==false? const LoginPage(): const MainPage()
            ),
    );
  }
}
