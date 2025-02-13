import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(5000, 50000);
  Map<String, bool> brands = {
    "Apple": false,
    "Samsung": false,
    "Google": false,
    "OnePlus": false,
    "Xiaomi": false,
  };

  Map<String, bool> conditions = {
    "Like New": false,
    "Excellent": false,
    "Good": false,
    "Fair": false,
    "Needs Repair": false,
  };

  List<String> storageOptions = [
    "16 GB",
    "32 GB",
    "64 GB",
    "128 GB",
    "256 GB",
    "512 GB",
    "1 TB"
  ];
  String? selectedStorage;

  List<String> ramOptions = ["2 GB", "4 GB", "6 GB", "8 GB", "12 GB", "16 GB"];
  String? selectedRAM;

  bool verifiedOnly = false;
  bool brandWarranty = false;
  bool sellerWarranty = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.8,
      // Wrap in SingleChildScrollView for overflow handling
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Filters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Each group is hidden until its header is tapped.
            ExpansionTile(
              title: const Text("Brand"),
              children: brands.keys
                  .map((option) => CheckboxListTile(
                title: Text(option),
                value: brands[option],
                onChanged: (val) =>
                    setState(() => brands[option] = val ?? false),
              ))
                  .toList(),
            ),
            ExpansionTile(
              title: const Text("Condition"),
              children: conditions.keys
                  .map((option) => CheckboxListTile(
                title: Text(option),
                value: conditions[option],
                onChanged: (val) =>
                    setState(() => conditions[option] = val ?? false),
              ))
                  .toList(),
            ),
            ExpansionTile(
              title: const Text("Storage"),
              children: [
                _buildDropdown("Storage", storageOptions, selectedStorage,
                        (val) => setState(() => selectedStorage = val))
              ],
            ),
            ExpansionTile(
              title: const Text("RAM"),
              children: [
                _buildDropdown("RAM", ramOptions, selectedRAM,
                        (val) => setState(() => selectedRAM = val))
              ],
            ),
            ExpansionTile(
              title: const Text("Additional Filters"),
              children: [
                _buildCheckbox("Verified Only", verifiedOnly,
                        (val) => setState(() => verifiedOnly = val ?? false)),
                _buildCheckbox("Brand Warranty", brandWarranty,
                        (val) => setState(() => brandWarranty = val ?? false)),
                _buildCheckbox("Seller Warranty", sellerWarranty,
                        (val) => setState(() => sellerWarranty = val ?? false)),
              ],
            ),
            ExpansionTile(
              title: const Text("Price Range"),
              children: [
                RangeSlider(
                  values: _priceRange,
                  min: 5000,
                  max: 100000,
                  divisions: 20,
                  labels: RangeLabels(
                      "₹${_priceRange.start.toInt()}",
                      "₹${_priceRange.end.toInt()}"),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: _clearFilters, child: const Text("Clear All")),
                ElevatedButton(onPressed: _applyFilters, child: const Text("Apply")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String title, List<String> options, String? selected,
      Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: selected,
        isExpanded: true,
        hint: Text("Select $title"),
        items:
        options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  void _clearFilters() {
    setState(() {
      brands.updateAll((key, value) => false);
      conditions.updateAll((key, value) => false);
      selectedStorage = null;
      selectedRAM = null;
      verifiedOnly = false;
      brandWarranty = false;
      sellerWarranty = false;
      _priceRange = const RangeValues(5000, 50000);
    });
  }

  void _applyFilters() {
    Navigator.pop(context, {
      "brands": brands,
      "conditions": conditions,
      "storage": selectedStorage,
      "ram": selectedRAM,
      "verifiedOnly": verifiedOnly,
      "brandWarranty": brandWarranty,
      "sellerWarranty": sellerWarranty,
      "priceRange": _priceRange,
    });
  }
}

Future<Map<String, dynamic>?> showFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    builder: (context) => FilterBottomSheet(),
  );
}
