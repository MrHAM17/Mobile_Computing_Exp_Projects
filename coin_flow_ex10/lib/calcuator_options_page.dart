import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

enum CalculatorCategory {
  IncomeTax,
  LoanEMI,
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  CalculatorCategory? _selectedCategory;
  TextEditingController incomeController = TextEditingController();
  TextEditingController principleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Text(
          'Coin Flow',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),

              // Calculator Category Dropdown
              DropdownButton<CalculatorCategory>(
                hint: Text('Select Calculator Category'),
                value: _selectedCategory,
                onChanged: (CalculatorCategory? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text('Income Tax Calculator'),
                    value: CalculatorCategory.IncomeTax,
                  ),
                  DropdownMenuItem(
                    child: Text('Loan EMI Calculator'),
                    value: CalculatorCategory.LoanEMI,
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Show selected calculator screen
              if (_selectedCategory == CalculatorCategory.IncomeTax)
                incomeTaxCalculator(),
              if (_selectedCategory == CalculatorCategory.LoanEMI)
                loanEMICalculator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget incomeTaxCalculator() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Income Tax Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: incomeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Income',
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      calculateTax();
                    },
                    child: Text('Calculate'),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    incomeController.clear();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loanEMICalculator() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Loan EMI Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: principleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Principle Amount',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Time (in months)',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Rate of Interest',
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      calculateEMI();
                    },
                    child: Text('Calculate'),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    principleController.clear();
                    timeController.clear();
                    rateController.clear();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Income Tax Calculation
  void calculateTax() {
    double income = double.tryParse(incomeController.text) ?? 0;
    double tax = 0;

    if (income <= 250000) {
      tax = 0;
    } else if (income <= 500000) {
      tax = (income - 250000) * 0.05;
    } else if (income <= 1000000) {
      tax = 12500 + (income - 500000) * 0.1;
    } else {
      tax = 112500 + (income - 1000000) * 0.15;
    }

    showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Income Tax Calculation'),
        content: Text('Income Tax = $tax'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  // Loan EMI Calculation
  void calculateEMI() {
    double p = double.tryParse(principleController.text) ?? 0;
    double n = double.tryParse(timeController.text) ?? 0;
    double r = double.tryParse(rateController.text) ?? 0;

    double rate = r / 1200;
    double res = (p * rate * pow(1 + rate, n)) / (pow(1 + rate, n) - 1);

    showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Loan EMI Calculation'),
        content: Text('EMI = $res'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
