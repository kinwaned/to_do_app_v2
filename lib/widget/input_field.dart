import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({Key? key, required this.title, required this.hint, this.widget, this.controller,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      readOnly: widget==null?false:true,
                      autofocus: false,
                      cursorColor: Get.isDarkMode? Colors.grey[100] : Colors.grey[700],
                      // controller: controller,
                      style: subTitleStyle,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subTitleStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                ),
                widget==null?Container():Container(child: widget,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
