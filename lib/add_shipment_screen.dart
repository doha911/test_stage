import 'package:flutter/material.dart';

class AddShipmentScreen extends StatefulWidget {
  const AddShipmentScreen({super.key});

  @override
  State<AddShipmentScreen> createState() => _AddShipmentScreenState();
}

class _AddShipmentScreenState extends State<AddShipmentScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCity;
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool dontAuthorize = false;

  final List<String> cityOptions = [
    'Value', // Default option
    '-- Grand Casablanca --',
    'Casablanca',
    'Mohammedia',
    'El Jadida',
    '-- Rabat-Salé-Kénitra --',
    'Rabat',
    'Salé',
    'Kénitra',
    '-- Fès-Meknès --',
    'Fès',
    'Meknès',
    'Ifrane',
    '-- Marrakech-Safi --',
    'Marrakech',
    'Safi',
    'Essaouira',
    '-- Tanger-Tétouan-Al Hoceïma --',
    'Tanger',
    'Tétouan',
    'Al Hoceïma',
    '-- Souss-Massa --',
    'Agadir',
    'Tiznit',
    '-- Oriental --',
    'Oujda',
    'Nador',
    'Berkane',
    '-- Béni Mellal-Khénifra --',
    'Béni Mellal',
    'Khouribga',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.local_shipping_outlined, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Add new shipment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildLabeledDropdown('City', cityOptions),
                      const SizedBox(height: 15),
                      buildLabeledField('Receiver Name', receiverNameController),
                      const SizedBox(height: 15),
                      buildLabeledField('Address', addressController),
                      const SizedBox(height: 15),
                      buildLabeledField('Phone', phoneController, TextInputType.phone),
                      const SizedBox(height: 15),
                      buildLabeledField('Price', priceController, TextInputType.number),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(
                            value: dontAuthorize,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                dontAuthorize = value ?? false;
                              });
                            },
                          ),
                          const Text("Don't Authorize to open box"),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Order added successfully!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'ADD NEW ORDER',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabeledField(String label, TextEditingController controller,
      [TextInputType inputType = TextInputType.text]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }

            if (label == 'Phone' && !RegExp(r'^\d{10}$').hasMatch(value)) {
              return 'Phone must be exactly 10 digits';
            }

            if (label == 'Price' && !RegExp(r'^\d+$').hasMatch(value)) {
              return 'Price must contain only numbers';
            }

            return null;
          },
          decoration: InputDecoration(
            hintText: label,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLabeledDropdown(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selectedCity ?? items.first,
          validator: (value) {
            if (value == null || value == 'Value' || value.startsWith('--')) {
              return 'Please select a valid city';
            }
            return null;
          },
          items: items.map((city) {
            if (city.startsWith('--')) {
              return DropdownMenuItem<String>(
                enabled: false,
                value: city,
                child: Text(
                  city.replaceAll('--', '').trim(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }
          }).toList(),
          onChanged: (value) => setState(() => selectedCity = value),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
