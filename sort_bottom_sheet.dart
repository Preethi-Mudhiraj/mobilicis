import 'package:flutter/material.dart';

void showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sort", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
              title: const Text("Value for Money"),
              leading: Radio(value: "value", groupValue: "sort", onChanged: (_) {}),
            ),
            ListTile(
              title: const Text("Price: Low to High"),
              leading: Radio(value: "low", groupValue: "sort", onChanged: (_) {}),
            ),
            ListTile(
              title: const Text("Price: High to Low"),
              leading: Radio(value: "high", groupValue: "sort", onChanged: (_) {}),
            ),
            ListTile(
              title: const Text("Latest"),
              leading: Radio(value: "latest", groupValue: "sort", onChanged: (_) {}),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Clear")),
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Apply")),
              ],
            )
          ],
        ),
      );
    },
  );
}
