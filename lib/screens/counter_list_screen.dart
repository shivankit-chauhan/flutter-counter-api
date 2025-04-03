import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/counter_service.dart';

class CounterListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Counters")),
      body: StreamBuilder(
        stream: CounterService().getUserCounters(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          final counters = snapshot.data!.docs;
          return ListView.builder(
            itemCount: counters.length,
            itemBuilder: (context, index) {
              final counter = counters[index];
              return ListTile(
                title: Text(counter['name']),
                subtitle: Text("Value: ${counter['value']}"),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    CounterService().incrementCounter(counter.id, counter['value']);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
