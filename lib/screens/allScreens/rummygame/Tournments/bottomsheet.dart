import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameEntryForm extends StatefulWidget {
  @override
  _GameEntryFormState createState() => _GameEntryFormState();
}

class _GameEntryFormState extends State<GameEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String selectedState = 'Rajasthan';
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top text & image/icon
          Row(
            children: [
              Expanded(
                child: Text(
                  'One last step before the game',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Icon(Icons.sports_esports, size: 40, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 20),

          Form(
            key: _formKey,
            child: Column(
              children: [
                // Email field (disabled)
                TextFormField(
                  initialValue: 'karansinghsaluja803@gmail.com',
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                    suffixIcon: Icon(Icons.verified, color: Colors.green),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // Full Name
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full name*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 15),

                // State and DOB
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedState,
                        items: ['Rajasthan', 'Delhi', 'Mumbai']
                            .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedState = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'State of Residence*',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: dobController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                              dobController.text =
                              '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Date of Birth*',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Select DOB' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Save & Play Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle save
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB5EB4C), // light green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save & Play',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
