import 'package:event_calendar/data/models/event_model.dart';
import 'package:event_calendar/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  final Box<Event> eventBox;

  const AddEventScreen({Key? key, required this.eventBox}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _eventTitleController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  Color _background = Colors.blue;
  bool _isAllDay = false;
  final _descriptionController = TextEditingController();
  String dbDataStartDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  

  @override
  void dispose() {
    _eventTitleController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  label: 'Event Title',
                  controller:
                  _eventTitleController,
                ),
                const SizedBox(height: 16.0),
                Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: InkWell(
                      onTap: () async {
                        var now = DateTime.now();
                        var res =
                        await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: now,
                          lastDate: DateTime(now
                              .copyWith(
                              year:
                              now.year + 1)
                              .year),
                        );
                        if (res != null) {
                          _startTimeController
                              .text = DateFormat(
                              "dd/MM/yyyy")
                              .format(res);
                          dbDataStartDate =
                              DateFormat(
                                  "yyyy-MM-dd")
                                  .format(res);
                          // formEGateCubit.setStartFrom(res);
                          // print("formatDate(res) ${formatDate(res)}");
                          print(
                              "formatDate(res) $res");
                        }
                      },
                      child: CustomTextFormField(
                        label: 'Select Date',
                        controller:
                        _startTimeController,
                        enabled: false,
                          activelyDisabled: true,
                        hintText: DateFormat("dd/MM/yyyy")
                            .format(DateTime.now()),
                      ),
                    )),

                TextFormField(
                  controller: _startTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Start Time',
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a start time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _endTimeController,
                  decoration: const InputDecoration(
                    labelText: 'End Time',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an end time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                // ColorPicker(
                //   selectedColor: _background,
                //   onColorChanged: (newColor) {
                //     setState(() {
                //       _background = newColor;
                //     });
                //   },
                // ),
                const SizedBox(height: 16.0),
                SwitchListTile(
                  title: const Text('All Day'),
                  value: _isAllDay,
                  onChanged: (value) {
                    setState(() {
                      _isAllDay = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final event = Event(
                        eventTitle: _eventTitleController.text,
                        startTime: DateTime.tryParse(_startTimeController.text),
                        endTime: DateTime.tryParse(_endTimeController.text),
                        background: _background,
                        isAllDay: _isAllDay,
                        description: _descriptionController.text,
                      );
                      widget.eventBox.add(event);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
