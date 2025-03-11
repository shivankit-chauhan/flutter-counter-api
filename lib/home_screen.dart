import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';

class HomeScreen extends StatelessWidget {
  final String namespace = "myApp";
  final String counterKey = "userClicks";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => counterProvider.fetchCounter(namespace, counterKey),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: counterProvider.isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Fetching data...", style: TextStyle(fontSize: 16))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (counterProvider.errorMessage.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(counterProvider.errorMessage,
                            style: TextStyle(color: Colors.red, fontSize: 16)),
                      ),

                    // Counter Display
                    Text(
                      "Counter: ${counterProvider.counter}",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),

                    // Button Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _customButton(context, "-", Colors.redAccent, () {
                          counterProvider.decrement(namespace, counterKey);
                        }),
                        _customButton(context, "+", Colors.green, () {
                          counterProvider.increment(namespace, counterKey);
                        }),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Set Counter Button
                    _customButton(context, "Set Counter", Colors.blue, () {
                      _showSetCounterDialog(context, counterProvider);
                    }),
                  ],
                ),
        ),
      ),
    );
  }

  // Custom Button Widget
  Widget _customButton(BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  // Dialog for Setting Counter Value
  void _showSetCounterDialog(BuildContext context, CounterProvider counterProvider) {
    int newValue = counterProvider.counter;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Counter Value"),
        content: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => newValue = int.tryParse(value) ?? counterProvider.counter,
          decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Enter a number"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              counterProvider.update(namespace, counterKey, newValue);
              Navigator.pop(context);
            },
            child: Text("Set"),
          )
        ],
      ),
    );
  }
}
