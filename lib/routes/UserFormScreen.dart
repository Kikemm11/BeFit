import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:be_fit/models/models.dart';
import 'package:be_fit/servers/servers.dart';

import 'package:be_fit/widgets/BeFitTextFormField.dart';
import 'package:be_fit/widgets/BeFitDropDownButtonFieldWidget.dart';

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedGender;
  int? _selectedBiotype;
  final TextEditingController _biotypeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _armCircumferenceController = TextEditingController();
  final TextEditingController _thighCircumferenceController = TextEditingController();

  // Fetch biotypes for initial state
  @override
  void initState() {
    super.initState();
    _fetchBiotypes();

  }

  Future<void> _fetchBiotypes() async {
    await context.read<BiotypeServer>().getAllBiotypes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'lib/assets/be_fit_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Form Overlay
            // Form Overlay
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Bienvenido',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.cyan[600],
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            BeFitTextFormFieldWidget(
                                controller: _nameController,
                                label: 'Nombre',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa tu nombre';
                                  }
                                  return null;
                                },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: BeFitTextFormFieldWidget(
                                    controller: _ageController,
                                    label: 'Edad',
                                    numeric: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor ingresa tu edad';
                                      }
                                      else if (int.tryParse(value)! <= 0){
                                        return 'Edad inválida';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                // CHANGE
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Género',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: {
                                          'M': 'Masculino',
                                          'F': 'Femenino',
                                        }
                                            .entries
                                            .map((entry) => DropdownMenuItem(
                                          value: entry.key,
                                          child: Text(entry.value),
                                        ))
                                            .toList(),
                                        onChanged: (value) { setState(() {
                                          _selectedGender = value;
                                        });},
                                        validator: (value) => value == null ? 'Por favor selecciona un género' : null,
                                      ),
                                    ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // CHANGE
                            Consumer<BiotypeServer>(
                                builder: (context, value, index) {
                                  return BeFitDropDownButtonFieldWidget(
                                      label: 'Biotipos',
                                      controller: _selectedBiotype,
                                      values: value.biotypes,
                                      icon: Icons.sports_gymnastics,
                                      onChange: (value) => {setState(() {_selectedBiotype = int.tryParse(value!);})},
                                      validator: (value) => value == null ? 'Por favor selecciona un biotipo' : null,
                                  );
                                }
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: BeFitTextFormFieldWidget(
                                    controller: _heightController,
                                    label: 'Altura (mts)',
                                    numeric: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor ingresa tu altura';
                                      }
                                      else if (double.tryParse(value)! <= 0.0){
                                        return 'Altura inválida';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: BeFitTextFormFieldWidget(
                                    controller: _weightController,
                                    label: 'Peso (Kg)',
                                    numeric: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor ingresa tu peso';
                                      }
                                      else if (double.tryParse(value)! <= 0.0){
                                        return 'Peso inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            BeFitTextFormFieldWidget(
                              controller: _armCircumferenceController,
                              label: 'Circunferencia Braquial (cm)',
                              numeric: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu circunferencia braquial';
                                }
                                else if (double.tryParse(value)! <= 0.0){
                                  return 'Medida inválida';
                                }
                                return null;
                              },
                            ),
                            BeFitTextFormFieldWidget(
                              controller: _thighCircumferenceController,
                              label: 'Circunferencia de Muslo (cm)',
                              numeric: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu circunferencia de muslo';
                                }
                                else if (double.tryParse(value)! <= 0.0){
                                  return 'Medida inválida';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Colors.cyan,
                                    size: 60,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      Profile profile = Profile(
                                          id: 1,
                                          name: _nameController.text,
                                          genre: _selectedGender!,
                                          age: int.tryParse(_ageController.text)!,
                                          biotypeId: _selectedBiotype!,
                                          height: double.tryParse(_heightController.text)!,
                                          weight: double.tryParse(_weightController.text)!,
                                          armMeasure: double.tryParse(_armCircumferenceController.text)!,
                                          legMeasure: double.tryParse(_thighCircumferenceController.text)!,
                                      );
                                      String result = await context.read<ProfileServer>().insertProfile(profile);
                                      if (result == 'Ok'){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Usuario creado satisfactoriamente!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, '/');
                                      }
                                      else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Ups, ha ocurrido un error!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }

                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDropdownField(String label, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Por favor selecciona un $label' : null,
      ),
    );
  }
}
