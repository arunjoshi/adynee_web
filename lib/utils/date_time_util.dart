import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static int currentMillis() {
    return new DateTime.now().microsecondsSinceEpoch;
  }

  static int dateTimeToMillis(DateTime dateTime) {
    return dateTime.microsecondsSinceEpoch ~/ 1000;
  }

  static String millisToString(int millis, {String? format}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return dateToString(dateTime, format: format);
  }

  static int? stringToMillis(String dateTimeStr, {String? format}) {
    DateTime? dateTime = stringToDate(dateTimeStr, format: format);
    if (dateTime == null) {
      return null;
    }
    return dateTimeToMillis(dateTime);
  }

  static String dateToString(DateTime dateTime, {String? format}) {
    format = format ?? "dd/MM/yyyy";
    DateFormat dateFormat = new DateFormat(format);
    return dateFormat.format(dateTime);
  }

  static String? changeDateFormat(String? dateStr, String fromFormat, String toFormat) {
    DateTime? dateTime = stringToDate(dateStr, format: fromFormat);
    if (dateTime != null) {
      return dateToString(dateTime, format: toFormat);
    } else {
      return null;
    }
  }

  static String? changeTimeFormat(String? timeStr, String fromFormat, String toFormat) {
    DateTime? dateTime = stringToDate(timeStr, format: fromFormat);
    if (dateTime != null) {
      return dateToString(dateTime, format: toFormat);
    } else {
      return null;
    }
  }

  static DateTime daysIntervalFromNow(int dayInterval) {
    DateTime now = DateTime.now();
    return DateUtils.addDaysToDate(now, dayInterval);
  }

  static DateTime? stringToDate(String? date, {String? format}) {
    try {
      if (date == null || date == "") {
        return null;
      }

      format = format ?? "dd/MM/yyyy";
      DateFormat dateFormat = new DateFormat(format);
      DateTime tempDate = dateFormat.parse(date);
      return tempDate;
    } catch (error, stacktrace) {
      return null;
    }
  }

  static String timeToString(TimeOfDay time, {DateFormat? dateFormat}) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    final DateFormat format = dateFormat ?? DateFormat.Hm(); //"23:55"
    return format.format(dt);
  }

  static TimeOfDay? stringToTime(String? time, {DateFormat? dateFormat}) {
    try {
      if (time == null || time == "") {
        return null;
      }

      DateFormat format = dateFormat ?? DateFormat.Hm(); //"23:55"
      return TimeOfDay.fromDateTime(format.parse(time));
    } catch (error, stacktrace) {
      return null;
    }
  }

  static Future<String?> pickDate(BuildContext aContext, {String? format, String? selectedDate, DateTime? firstDate, DateTime? lastDate}) async {

    print('format asfas $format');

    format = format ?? "dd/MM/yyyy";
    DateTime selectedDateTime = stringToDate(selectedDate, format: format) ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: aContext,

      initialDate: selectedDateTime,
      //initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate ?? DateTime(1970),
      lastDate: lastDate ?? DateTime(DateTime.now().day),
    );
    return picked != null ? dateToString(picked, format: format) : null;
  }

  static Future<String?> pickTime(
    BuildContext aContext, {
    String? selectedTime,
    DateFormat? dateFormat,
    // bool? futureTimeNotAllowed,
    // String? futureLimitDate,
  }) async {
    TimeOfDay selectedTimeOfDay = stringToTime(selectedTime, dateFormat: dateFormat) ?? TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: aContext,
      initialTime: selectedTimeOfDay,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    String? pickedStr = picked != null ? timeToString(picked, dateFormat: dateFormat) : null;

    // if ((futureTimeNotAllowed ?? false) && pickedStr != null) {
    //   //Check Future time and empty
    //   futureLimitDate = futureLimitDate ?? dateToString(DateTime.now());
    //   futureLimitDate = futureLimitDate + ' ' + pickedStr!;
    //   DateTime? futureLimitDateTime = stringToDate(futureLimitDate, format: "dd/MM/yyyy HH:mm");
    //   if ((futureLimitDateTime ?? DateTime.now()).difference(DateTime.now()).inMinutes > -1) {
    //     // Validation failed
    //     Dialogs.toastError("You cannot select future time");
    //     pickedStr = "";
    //   }
    // }

    return pickedStr;
  }

  static Future<String?> pickDateTime(BuildContext aContext, {String? format, String? selectedDate, DateTime? firstDate, DateTime? lastDate}) async {
    format = format ?? "dd/MM/yyyy HH:mm";
    DateTime selectedDateTime = stringToDate(selectedDate, format: format) ?? DateTime.now();
    final TimeOfDay? time;
    final DateTime? picked = await showDatePicker(
      context: aContext,
      initialDate: selectedDateTime,
      //initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate ?? DateTime(1970),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 10),
    );
    if (picked != null) {
      time = await showTimePicker(
        context: aContext,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
    }
    return picked != null ? dateToString(picked, format: format) : null;
  }

  static bool isValidFromAndToDate(String? dateFrom, String? dateTo, {String? format}) {
    if ((dateFrom?.isEmpty ?? true) || (dateTo?.isEmpty ?? true)) {
      return true; // no error
    }

    DateTime? startDate = stringToDate(dateFrom, format: format);
    DateTime? endDate = stringToDate(dateTo, format: format);
    if (startDate != null && endDate != null) {
      // conversion success
      if (endDate.difference(startDate).inDays > -1) {
        // DateFrom is less or equal to dateTo: No Error
        return true;
      }
      return false;
    } else {
      // error in conversion
      return false;
    }
  }

  static bool isValidFromTimeAndToTime(String? fromTime, String? toTime, {String? fromTimeFormat, String? toTimeFormat}) {
    if ((fromTime?.isEmpty ?? true) || (toTime?.isEmpty ?? true)) {
      return true; // no error
    }

    if (fromTime?.length == 5) {
      // No Date: Add Today's date
      fromTime = dateToString(DateTime.now()) + ' ' + fromTime!;
      fromTimeFormat = "dd/MM/yyyy HH:mm";
    }
    if (toTime?.length == 5) {
      // No Date: Add Today's date
      toTime = dateToString(DateTime.now()) + ' ' + toTime!;
      toTimeFormat = "dd/MM/yyyy HH:mm";
    }

    DateTime? startDate = stringToDate(fromTime!, format: fromTimeFormat);
    DateTime? endDate = stringToDate(toTime!, format: toTimeFormat);
    if (startDate != null && endDate != null) {
      // conversion success
      if (endDate.difference(startDate).inMinutes > -1) {
        // DateFrom is less or equal to dateTo: No Error
        return true;
      }
      return false;
    } else {
      // error in conversion
      return false;
    }
  }
}
