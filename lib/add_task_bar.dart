
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/ui/theme.dart';
import 'package:to_do_app/widget/button.dart';
import 'package:to_do_app/widget/input_field.dart';

import 'controllers/task_controller.dart';
import 'models/tasks.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = '12:00 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _mainRemind = 5;
  List<int> remindList=[
    5, 10, 15, 20,
  ];
  String _mainRepeat = 'None';
  List<String> repeatList=[
    'None', 'Daily', 'Weekly', 'Monthly',
  ];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: HeadingStyle,
              ),
              SizedBox(height: 16,),
              MyInputField(title: 'Title', hint: 'Enter your title here',controller: _titleController,),
              SizedBox(height: 16,),
              MyInputField(title: 'Note', hint: 'Enter your note here',controller: _noteController,),
              SizedBox(height: 16,),
              MyInputField(title: 'Date', hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: (){
                    _datePickerFromUser();
                  },
                  icon: Icon(Icons.calendar_today_outlined),
                color: Colors.grey,)
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                          title: 'Start Date',
                          hint: _startTime,
                          widget: IconButton(
                              onPressed: (){
                                _timePickerFromUser(isStartTime: true);
                              },
                              icon: Icon(Icons.access_time_rounded),
                          color: Colors.grey,),
                      )
                  ),
                  SizedBox(width: 18,),
                  Expanded(
                      child: MyInputField(
                        title: 'End Date',
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: (){
                            _timePickerFromUser(isStartTime: false);
                          },
                          icon: Icon(Icons.access_time_rounded),
                          color: Colors.grey,),
                      ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              MyInputField(title: 'Reminder', hint: '$_mainRemind minutes early'
                  ,widget: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                      setState(() {
                        _mainRemind = int.parse(newValue!);
                      });
                },
                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child:Text(value.toString()),
                    );
                  }
                  ).toList(),
                ),
              ),
              SizedBox(height: 16,),
              MyInputField(title: 'Reminder', hint: _mainRepeat
                ,widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _mainRepeat = newValue!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child:Text(value!, style: TextStyle(color: Colors.grey),),
                    );
                  }
                  ).toList(),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _colorPalette(),
                  SizedBox(
                    height: 45,
                      child: MyButton(label: 'Create Task', onTap: (){
                        return _validateDate();
                      }))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _colorPalette(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: index==0? bluishClr : index==1?pinkClr : yellowClr,
                      child: _selectedColor==index? Icon(Icons.done, color: Colors.white, size: 16,): Container(),
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
  _validateDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addDataToDb();
      Get.back();
    }else if (_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar('Required', 'All fields must be filled!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red,),
      );
    }
  }

  _addDataToDb() async {
   int value =await _taskController.addTask(
        task:Task(
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          remind: _mainRemind,
          repeat: _mainRepeat,
          color: _selectedColor,
          isCompleted: 0,
        )
    );
   print('My id is ''$value');
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child:
        Icon(
          Icons.arrow_back_ios,
          size: 20.0,
          color: Get.isDarkMode? Colors.white :Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("images/user2.png"),
        ),
        SizedBox(
          width: 20.0,
        ),
      ],
    );
  }

  _datePickerFromUser() async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
    );
    if (_datePicker != null){
      setState(() {
        _selectedDate = _datePicker;
      });
    }
    else {
      print('Date must be submitted!');
    }
  }

  _timePickerFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _timeFormat =  pickedTime.format(context);
    if(pickedTime==null){
      print('Time selection was canceled');
    }
    else if(isStartTime == true ){
      setState(() {
        _startTime = _timeFormat;
      });
    }
    else if(isStartTime == false){
      setState(() {
        _endTime = _timeFormat;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
        )
    );
  }
}
