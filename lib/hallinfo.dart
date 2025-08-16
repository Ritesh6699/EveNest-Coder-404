import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HallFormPage extends StatefulWidget {
  const HallFormPage({super.key});

  @override
  State<HallFormPage> createState() => _HallFormPageState();
}

class _HallFormPageState extends State<HallFormPage> {
  final _formKey = GlobalKey<FormState>();

  String hallName = '';
  String address = '';
  String capacity = '';
  String contact = '';
  String amenities = '';
  List<XFile?> images = [null, null, null];

  Future<void> _pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        images[index] = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Add Hall Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.95
                  : 400,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(color: const Color(0xFFD4AF37), width: 2),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _inputField(
                      label: "Hall Name",
                      icon: Icons.home_work,
                      onSaved: (val) => hallName = val ?? '',
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter hall name" : null,
                    ),
                    const SizedBox(height: 20),
                    _inputField(
                      label: "Address",
                      icon: Icons.location_on,
                      onSaved: (val) => address = val ?? '',
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter address" : null,
                    ),
                    const SizedBox(height: 20),
                    _inputField(
                      label: "Capacity",
                      icon: Icons.groups,
                      keyboardType: TextInputType.number,
                      onSaved: (val) => capacity = val ?? '',
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter capacity" : null,
                    ),
                    const SizedBox(height: 20),
                    _inputField(
                      label: "Contact Number",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      onSaved: (val) => contact = val ?? '',
                      validator: (val) => val == null || val.isEmpty
                          ? "Enter contact number"
                          : null,
                    ),
                    const SizedBox(height: 20),
                    _inputField(
                      label: "Amenities",
                      icon: Icons.check_circle,
                      maxLines: 2,
                      onSaved: (val) => amenities = val ?? '',
                    ),
                    const SizedBox(height: 20),

                    // Image Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => _pickImage(index),
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFD4AF37),
                                    width: 2,
                                  ),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: images[index] == null
                                    ? Icon(
                                        Icons.add_a_photo,
                                        size: 38,
                                        color: const Color(0xFFD4AF37),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(images[index]!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Image ${index + 1}",
                              style: const TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Check if all images are selected
                            if (images.any((img) => img == null)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select all three images.',
                                  ),
                                ),
                              );
                              return;
                            }
                            // Handle form submission & images
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text(
                                  "Hall Added",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  "Community Hall details and images submitted successfully!",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
  }) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFD4AF37), fontSize: 18),
        prefixIcon: Icon(icon, color: Color(0xFFD4AF37)),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD4AF37)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD4AF37)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF0D680), width: 2),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
