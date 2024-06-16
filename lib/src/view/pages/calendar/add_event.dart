import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_drawer.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_header.dart';
import 'package:we_connect_iui_mobile/src/view/components/header_text.dart';
import 'package:we_connect_iui_mobile/src/view/pages/calendar/calendar.dart';

const List<String> list1 = <String>['B01', 'B02', 'B03', 'B04'];
const List<String> list2 = <String>['S11', 'S22', 'S33', 'S44'];

class AddEventCalendar extends StatefulWidget {
  const AddEventCalendar({Key? key}) : super(key: key);

  @override
  _AddEventCalendarState createState() => _AddEventCalendarState();
}

class _AddEventCalendarState extends State<AddEventCalendar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  String _selectedEventType = "Class";
  DateTime? _selectedDateFrom;
  TimeOfDay? _selectedTimeFrom;
  DateTime? _selectedDateTo;
  TimeOfDay? _selectedTimeTo;
  String _selectedRoom = list1.first;
  String _selectedRoom2 = list2.first;

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _selectedDateFrom = picked;
        } else {
          _selectedDateTo = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _selectedTimeFrom = picked;
        } else {
          _selectedTimeTo = picked;
        }
      });
    }
  }

  Future<void> _saveEventToSupabase() async {
    if (_formKey.currentState!.validate()) {
      final SupabaseClient supabase = Supabase.instance.client;

      // Ensure dates and times are properly formatted
      final String dateFrom = _selectedDateFrom?.toIso8601String() ?? '';
      final String dateTo = _selectedDateTo?.toIso8601String() ?? '';
      final String timeFrom = _selectedTimeFrom != null
          ? '${_selectedTimeFrom!.hour.toString().padLeft(2, '0')}:${_selectedTimeFrom!.minute.toString().padLeft(2, '0')}'
          : '';
      final String timeTo = _selectedTimeTo != null
          ? '${_selectedTimeTo!.hour.toString().padLeft(2, '0')}:${_selectedTimeTo!.minute.toString().padLeft(2, '0')}'
          : '';

      // Extract text from the controllers
      final String title = _titleController.text.trim();
      final String instructor = _instructorController.text.trim();

      // Construct the event payload
      final Map<String, dynamic> event = {
        'title': title,
        'event_type': _selectedEventType,
        'date_from': dateFrom,
        'time_from': timeFrom,
        'date_to': dateTo,
        'time_to': timeTo,
        'room1': _selectedRoom,
        'room2': _selectedRoom2,
        'instructor': instructor,
      };

      // Log the payload for debugging
      print('Request Payload: $event');

      final response = await supabase.from('events').insert(event);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Calendar()));
      // if (response.error == null) {
      //   print('Event saved successfully');
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Calendar()));
      // } else {
      //   print('Error inserting data: ${response.error!.message}');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: AppBar(
          backgroundColor: AppColor.header,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Add Event",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: screenHeight * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * 0.87,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Add title',
                      hintStyle: TextStyle(
                        color: AppColor.tertiary,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Syne",
                        fontSize: 20,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.black),
                      ),
                    ),
                    style: TextStyle(
                      color: AppColor.black,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Syne",
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(width: screenHeight * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Event Type",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Syne",
                        color: AppColor.black,
                      ),
                    ),
                    Spacer(),
                    _buildEventTypeButton("Class", screenHeight),
                    SizedBox(width: 10),
                    _buildEventTypeButton("Test", screenHeight),
                  ],
                ),
              ),
              SizedBox(width: screenHeight * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "From",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Syne",
                        color: Theme.of(context).textTheme.displayMedium!.color,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(
                        _selectedDateFrom == null
                            ? 'Select Date'
                            : '${_selectedDateFrom!.day}/${_selectedDateFrom!.month}/${_selectedDateFrom!.year}',
                        style: TextStyle(
                          fontFamily: "Syne",
                          fontSize: 20,
                          color: AppColor.tertiary,
                        ),
                      ),
                    ),
                    SizedBox(width: screenHeight * 0.04),
                    TextButton(
                      onPressed: () => _selectTime(context, true),
                      child: Text(
                        _selectedTimeFrom == null
                            ? 'Select Time'
                            : _selectedTimeFrom!.format(context),
                        style: TextStyle(
                          fontFamily: "Syne",
                          fontSize: 20,
                          color: AppColor.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenHeight * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "To",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Syne",
                        color: Theme.of(context).textTheme.displayMedium!.color,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(
                        _selectedDateTo == null
                            ? 'Select Date'
                            : '${_selectedDateTo!.day}/${_selectedDateTo!.month}/${_selectedDateTo!.year}',
                        style: TextStyle(
                          fontFamily: "Syne",
                          fontSize: 20,
                          color: AppColor.tertiary,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () => _selectTime(context, false),
                      child: Text(
                        _selectedTimeTo == null
                            ? 'Select Time'
                            : _selectedTimeTo!.format(context),
                        style: TextStyle(
                          fontFamily: "Syne",
                          fontSize: 20,
                          color: AppColor.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenHeight * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.door_front_door_outlined,
                        color:
                            Theme.of(context).textTheme.displayMedium!.color),
                    SizedBox(width: 10),
                    Text(
                      "Room",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Syne",
                        color: Theme.of(context).textTheme.displayMedium!.color,
                      ),
                    ),
                    Spacer(),
                    DropdownButton<String>(
                      dropdownColor: AppColor.tertiary,
                      value: _selectedRoom2,
                      icon: Icon(Icons.arrow_downward,
                          color:
                              Theme.of(context).textTheme.displayMedium!.color),
                      elevation: 16,
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayMedium!.color,
                          fontFamily: "Syne",
                          fontSize: 20),
                      underline: Container(
                        height: 2,
                        color: AppColor.tertiary,
                      ),
                      items:
                          list2.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedRoom2 = value!;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      dropdownColor: AppColor.tertiary,
                      value: _selectedRoom,
                      icon: Icon(Icons.arrow_downward,
                          color:
                              Theme.of(context).textTheme.displayMedium!.color),
                      elevation: 16,
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayMedium!.color,
                          fontFamily: "Syne",
                          fontSize: 20),
                      underline: Container(
                        height: 2,
                        color: AppColor.tertiary,
                      ),
                      items:
                          list1.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedRoom = value!;
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(width: screenHeight * 0.04),
              Container(
                width: screenWidth * 0.87,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _instructorController,
                    decoration: const InputDecoration(
                      hintText: 'Add Instructor',
                      hintStyle: TextStyle(
                        color: AppColor.tertiary,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Syne",
                        fontSize: 20,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.black),
                      ),
                    ),
                    style: TextStyle(
                      color: AppColor.black,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Syne",
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an instructor';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: AppColor.black,
                        ),
                        onPressed: () {
                          //print(
                          //   "$_selectedDateFrom,$_selectedDateTo,$_selectedTimeFrom,$_selectedTimeTo,$_titleController,$_selectedRoom,$_selectedRoom2,$_instructorController");
                          if (_formKey.currentState!.validate()) {
                            _saveEventToSupabase();
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: AppColor.white,
                              fontStyle: FontStyle.italic,
                              fontFamily: "Syne",
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventTypeButton(String eventType, double screenHeight) {
    bool isSelected = _selectedEventType == eventType;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEventType = eventType;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: isSelected ? screenHeight * 0.06 : screenHeight * 0.05,
        width: isSelected ? 120 : 110,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.tertiary : AppColor.success,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          eventType,
          style: TextStyle(
            color: isSelected ? AppColor.white : AppColor.black,
            fontSize: isSelected ? 20 : 18,
            fontFamily: "Syne",
          ),
        ),
      ),
    );
  }
}
