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
  String dbDataEventDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final _eventTitleController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _startTimeController = TextEditingController(text: "00:00");
  final _endTimeController = TextEditingController(text: "00:00");
  Color _background = Colors.blue;
  bool _isAllDay = false;
  final _descriptionController = TextEditingController();
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();

  @override
  void initState() {
    _eventDateController.text = DateFormat(
        "dd/MM/yyyy")
        .format(DateTime.now());
    super.initState();
  }

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
                  autofocus: false,
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
                          setState(() {
                            startDateTime = res;
                          });
                          _eventDateController
                              .text = DateFormat(
                              "dd/MM/yyyy")
                              .format(res);
                          dbDataEventDate =
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
                        _eventDateController,
                        enabled: false,
                          activelyDisabled: true,
                        hintText: DateFormat("dd/MM/yyyy")
                            .format(DateTime.now()),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(children: [
                    Expanded(
                        child: InkWell(
                          onTap: () async {
                            var now = DateTime.now();
                            var timeNow = TimeOfDay(hour: now.hour, minute: now.minute);
                            var res =
                            await showTimePicker(
                              context: context,
                              initialTime: timeNow,
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                            if (res != null) {
                              setState(() {
                                startDateTime = startDateTime.copyWith(hour: res.hour, minute: res.minute);
                              });
                              _startTimeController
                                  .text = DateFormat(
                                  "HH:mm")
                                  .format(startDateTime);
                              dbDataEventDate =
                                  DateFormat(
                                      "yyyy-MM-dd")
                                      .format(startDateTime);
                              // formEGateCubit.setStartFrom(res);
                              // print("formatDate(res) ${formatDate(res)}");
                              print(
                                  "formatDate(res) $res");
                            }
                          },
                          child: CustomTextFormField(
                            label: 'Start Time',
                            controller:
                            _startTimeController,
                            enabled: false,
                            activelyDisabled: true,
                            hintText: DateFormat("HH:mm")
                                .format(DateTime.now().copyWith(hour: 0,minute: 0)),
                          ),
                        )),
                    const SizedBox(width: 8,),
                    Expanded(
                        child: InkWell(
                          onTap: () async {
                            var now = DateTime.now();
                            var timeNow = TimeOfDay(hour: now.hour, minute: now.minute);
                            var res =
                            await showTimePicker(
                              context: context,
                              initialTime: timeNow,
                            );
                            if (res != null) {
                              print("End Time: ${res.hour}");
                              setState(() {
                                endDateTime = startDateTime.copyWith(hour: res.hour, minute: res.minute);
                              });
                              print("End Time Date: ${endDateTime.hour}");

                              _endTimeController
                                  .text = DateFormat(
                                  "HH:mm")
                                  .format(endDateTime);
                              dbDataEventDate =
                                  DateFormat(
                                      "yyyy-MM-dd")
                                      .format(endDateTime);
                              // formEGateCubit.setStartFrom(res);
                              // print("formatDate(res) ${formatDate(res)}");
                              print(
                                  "formatDate(res) $res");
                            }
                          },
                          child: CustomTextFormField(
                            label: 'End Time',
                            controller:
                            _endTimeController,
                            enabled: false,
                            activelyDisabled: true,
                            hintText: DateFormat("HH:mm")
                                .format(DateTime.now().copyWith(hour: 0,minute: 0)),
                          ),
                        )),
                  ],),
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
                CustomTextFormField(
                  autofocus: false,
                  label: 'Event Description',
                  controller:
                  _descriptionController,
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final event = Event(
                        eventTitle: _eventTitleController.text,
                        startTime: DateTime.tryParse(_startTimeController.text),
                        endTime: DateTime.tryParse(_endTimeController.text),
                        backgroundHex: _background.value,
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
