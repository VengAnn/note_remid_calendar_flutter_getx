import 'package:flutter/material.dart';

class DialogShow extends StatelessWidget {
  const DialogShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*9,
      color: Colors.amber,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Start Time:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter start time',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select End Time:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter end time',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Title:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter title',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement your logic to handle save button click
                },
                child: const Text('Save'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // Implement your logic to handle cancel button click
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
