import 'package:flutter/material.dart';

import '../shared/utils.dart' show CalendarFormat;

class FormatButton extends StatefulWidget {
  final CalendarFormat calendarFormat;
  final ValueChanged<CalendarFormat> onTap;
  final TextStyle textStyle;
  final Decoration decoration;
  final EdgeInsets padding;
  bool showsNextFormat;

  String newValue = "Week";
  final Map<CalendarFormat, String> availableCalendarFormats;

  FormatButton({
    Key? key,
    required this.calendarFormat,
    required this.onTap,
    required this.textStyle,
    required this.decoration,
    required this.padding,
    this.newValue = "Week",
    this.showsNextFormat = true,
    required this.availableCalendarFormats,
  }) : super(key: key);

  @override
  State<FormatButton> createState() => _FormatButtonState();
}

class _FormatButtonState extends State<FormatButton> {
  CalendarFormat? currrentFormat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currrentFormat = widget.calendarFormat;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: DropdownButton<String>(
          value: getCurrent(),
          elevation: 0,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 0,
            color: Colors.blue,
          ),
          onChanged: (String? newValue) {
            if (newValue == "Week") {
              widget.showsNextFormat = false;
              widget.onTap(_nextFormat1(CalendarFormat.week));
              currrentFormat = CalendarFormat.week;
              setState(() {});
            } else if (newValue == "2 weeks") {
              widget.showsNextFormat = false;
              widget.onTap(_nextFormat1(CalendarFormat.twoWeeks));
              currrentFormat = CalendarFormat.twoWeeks;
              setState(() {});
            } else if (newValue == "Month") {
              widget.showsNextFormat = false;
              widget.onTap(_nextFormat1(CalendarFormat.month));
              currrentFormat = CalendarFormat.month;
              setState(() {});
            }
          },
          items: <String>['Week', '2 weeks', 'Month']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFFE8570F),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                          child: Image.asset(
                        value == 'Week'
                            ? "assets/icons/calendar.png"
                            : value == "2 weeks"
                                ? "assets/icons/calendar1.png"
                                : "assets/icons/calendar3.png",
                      ))),
                  SizedBox(
                    width: 16 / 2,
                  ),
                  Text(
                    value,
                    style: widget.textStyle,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  CalendarFormat _nextFormat1(CalendarFormat calendarFormat) {
    final formats = widget.availableCalendarFormats.keys.toList();
    int id = formats.indexOf(calendarFormat);
    return formats[id];
  }

  String getCurrent() {
    if (widget.showsNextFormat == false) {
      if (currrentFormat == CalendarFormat.month) {
        return "Month";
      } else if (currrentFormat == CalendarFormat.week) {
        return "Week";
      } else if (currrentFormat == CalendarFormat.twoWeeks) {
        return "2 weeks";
      } else {
        return "";
      }
    } else {
      if (widget.calendarFormat == CalendarFormat.month) {
        return "Month";
      } else if (widget.calendarFormat == CalendarFormat.week) {
        return "Week";
      } else if (widget.calendarFormat == CalendarFormat.twoWeeks) {
        return "2 weeks";
      } else {
        return "";
      }
    }
  }

  String get _formatButtonText => widget.showsNextFormat
      ? widget.availableCalendarFormats[_nextFormat()]!
      : widget.availableCalendarFormats[currrentFormat]!;

  CalendarFormat _nextFormat() {
    final formats = widget.availableCalendarFormats.keys.toList();
    int id = formats.indexOf(widget.calendarFormat);
    id = (id + 1) % formats.length;
    return formats[id];
  }
}
