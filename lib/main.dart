// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_import, unused_local_variable, sized_box_for_whitespace

import 'dart:ffi';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'dart:math';

import '../models/transaction.dart';
import '../components/transaction_form.dart';
import '../components/transaction_list.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    _generateId() {
      //Retorna o timestamp em milisegundos
      return DateTime.now().millisecondsSinceEpoch.toString();
    }

    // ignore: unnecessary_new
    final newTransaction = new Transaction(
      id: _generateId(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBarWidget = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(fontSize: 16 * mediaQuery.textScaleFactor),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        if (_isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.bar_chart_rounded),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        )
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBarWidget.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBarWidget,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            if (_showChart || !_isLandscape)
              Container(
                height: availableHeight * (_isLandscape ? 0.7 : 0.35),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !_isLandscape)
              Container(
                height: availableHeight * (_isLandscape ? 1 : 0.65),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
