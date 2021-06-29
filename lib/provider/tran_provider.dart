import 'package:example_max4/models/transaction.dart';
import 'package:example_max4/widgets/new_Transaction.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
class TranProvider with ChangeNotifier {
  List<Transactions> userTransaction = [];
double total=0.0;
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction();

        });

  }

  void deleteTransaction(String id)async {
    final dp=await getDB();
  await dp.rawDelete('DELETE FROM tran_user WHERE id=?',[id]);
    userTransaction.removeWhere((element) => element.id == id);
  notifyListeners();
  }

  Future<void> addNewTransaction(
      String txTitle, double txAmount, DateTime dateTime) async {
    final String data = DateTime.now().toString();
    final ex = Transactions(
        time: dateTime, id: data, amount: txAmount, title: txTitle);

    final dp = await getDB();
    dp.insert('tran_user', {
      'title': txTitle,
      'amount': txAmount,
      'time': dateTime.toIso8601String(),
      'id': data
    });

      userTransaction.add(ex);
      notifyListeners();
  }

  Future<sql.Database> getDB() async {
    final dpPath = await sql.getDatabasesPath();
    return sql.openDatabase(p.join(dpPath, 'tran.db'), version: 1,
        onCreate: (dp, version) {
      return dp.execute(
          'CREATE TABLE tran_user(time TEXT,id TEXT,amount REAL,title TEXT)');
    });
  }

  Future<void> get recentTransaction async {
    try {
      final dp = await getDB();
      final listTran = await dp.query('tran_user');
      final aa = listTran
          .map((e) => Transactions(
              id: e['id'],
              time: DateTime.parse(e['time']),
              amount: e['amount'],
              title: e['title']))
          .toList();
      var tran = aa.where((el) {
        return el.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
      userTransaction = tran;
      notifyListeners();
//      return userTransaction;

    } catch (e) {print(e);}}





}