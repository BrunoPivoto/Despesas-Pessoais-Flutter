import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final ThemeData tema = ThemeData();
    final mediaQuery = MediaQuery.of(context);
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.purple.shade400,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18 * mediaQuery.textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16 * mediaQuery.textScaleFactor,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
              labelLarge: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20 * mediaQuery.textScaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Gasto fixo 01',
        value: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: 't1',
        title: 'Gasto fixo 01',
        value: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: 't1',
        title: 'Gasto fixo 01',
        value: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: 't1',
        title: 'Gasto fixo 01',
        value: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: 't1',
        title: 'Gasto fixo 01',
        value: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: 't1',
        title: 'Gasto fixo 01',
        value: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: 't2',
        title: 'Gasto fixo 02',
        value: 25,
        date: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(
        id: 't3',
        title: 'Gasto fixo 03',
        value: 36,
        date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(
        id: 't4',
        title: 'Gasto fixo 04',
        value: 99,
        date: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(
        id: 't5',
        title: 'Gasto fixo 05',
        value: 146,
        date: DateTime.now().subtract(const Duration(days: 45))),
    Transaction(
        id: 't6',
        title: 'Gasto fixo 06',
        value: 63,
        date: DateTime.now().subtract(const Duration(days: 15))),
    Transaction(
        id: 't7',
        title: 'Gasto fixo 07',
        value: 78,
        date: DateTime.now().subtract(const Duration(days: 5))),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return TransactionForm(
            onSubmit: _addTransaction,
          );
        });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      titleSpacing: 10,
      toolbarHeight: 70,
      title: const Text('Despesas Pessoais'),
      actions: [
        Switch(
          value: _showChart,
          onChanged: (value) {
            setState(() {
              _showChart = value;
            });
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 24.0, 20, 0),
          child: Text('7 dias'),
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 2, 10, 15),
        //   child: IconButton(
        //     onPressed: () {
        //       _openTransactionFormModal(context);
        //     },
        //     icon: const Icon(
        //       Icons.add,
        //       size: 50,
        //     ),
        //   ),
        // )
      ],
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //scrollDirection: Axis.vertical,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart)
              SizedBox(
                  height: availableHeight * (isLandscape ? 1 : 0.4),
                  child: Chart(recentTransactions: _recentTransactions)),
            //if (!_showChart)
            SizedBox(
              height: availableHeight * 0.9,
              child: TransactionList(
                  transactions: _transactions, onDelete: _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openTransactionFormModal(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
