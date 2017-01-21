import 'dart:html';
import 'dart:js';

/// Basic dart wrapper around the Pikaday-js lib. You will have to
/// link to pikaday.js (Get the latest version from it's
/// [GitHub page](https://github.com/dbushell/Pikaday) and if you want
/// a custom date format (which is highly likable) also to [moment.js](http://momentjs.com/)).
///
/// Attribute documentation adapted from the
/// [pikaday.js documentation](https://github.com/dbushell/Pikaday).

/// Upgrade the input element to a DatePicker.
/// Invoke onSelectDay when a date is selected (and provide it as a parameter).
/// Optionally return the js-wrapper object. (Implementation may change).
upgradeInputToDatepicker(
    InputElement datepickerElem,
    onSelectDay(DateTime),
    PikadayParams params) {

  assert(datepickerElem!=null);
  assert(onSelectDay!=null);
  assert(params!=null);

  Map<String, dynamic> paramsMap = params.asMap();
  paramsMap['field'] = datepickerElem;
  paramsMap['onSelect'] = onSelectDay;

  JsObject jsPikaday = new JsObject(
      context['Pikaday'],
      [new JsObject.jsify(paramsMap)]);

  return jsPikaday;
}

class PikadayParams {
  /// Corresponds to defaultDate in pikaday.js, which is the initially
  /// selected date of the datepicker.
  DateTime defaultDay;

  /// Corresponds to setDefaultDate in pikaday.js but is true by default.
  /// It becomes only active, if day is provided. (Class: bool or boolString)
  dynamic showDayOnInit = true;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Automatically show/hide the datepicker on field focus.
  /// Defaults to true. (Class: bool or boolString)
  dynamic bound;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Determines the preferred position of the datepicker
  /// relative to the form field, e.g.: 'top right', 'bottom right'.
  /// Note: automatic adjustment may occur to avoid datepicker from being
  /// displayed outside the viewport.
  /// Defaults to 'bottom left'.
  String position;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// This can be set to false to not reposition datepicker within the viewport,
  /// forcing it to take the configured position.
  /// Defaults to true. (Class: bool or boolString)
  dynamic reposition;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// This is the default output format of this datepicker.
  /// (It requires Moment.js for custom formatting)
  String format;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// This is the default flag for moment's strict date parsing.
  /// (It requires Moment.js for custom formatting) (Class: bool or boolString)
  dynamic formatString;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Sets the first day of the week (0: Sunday, 1: Monday, etc).
  /// (Class: int or intString)
  dynamic firstDay;

  /// Corresponds to minDate in pikaday.js.
  /// Will be parsed as to a DateTime and determines the minimum/earliest date
  /// that can be selected.
  /// (Class: DateTime or dayString with format: 'yyyy-mm-dd')
  dynamic minDate;

  /// Corresponds to maxDate in pikaday.js.
  /// Will be parsed as to a DateTime and determines the maximum/latest date
  /// that can be selected.
  /// (Class: DateTime or dayString with format: 'yyyy-mm-dd')
  dynamic maxDate;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Set to true to disallow selection of Saturdays or Sundays.
  /// (Class: bool or boolString)
  dynamic disableWeekends;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Number of years either side (e.g. 10) or array of upper/lower range
  /// (e.g. [1900,2015]). Value will be discarded if the it's neither an int
  /// nor a list of two ascending ints.
  /// If neither is provided, the component tries to fall back on the year of
  /// [minDate] and [maxDate]
  dynamic yearRange;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Show the ISO week number at the head of the row.
  /// Defaults to false. (Class: bool or boolString)
  dynamic showWeekNumber;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Reverse the calendar for right-to-left languages.
  /// (Class: bool or boolString)
  dynamic isRTL;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Determines language defaults for month and weekday names.
  /// Values should be of type String or List<String>.
  Map<String, dynamic> i18n;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Add an additional text to append to the year in the title.
  String yearSuffix;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Render the month after year in the title.
  /// Defaults to false. (Class: bool or boolString)
  dynamic showMonthAfterYear;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Renders days of the calendar grid that fall in the next or previous months
  /// to the current month instead of rendering an empty table cell.
  /// Defaults to false. (Class: bool or boolString)
  dynamic showDaysInNextAndPreviousMonths = true;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Determines the number of visible calendars.
  /// Defaults to true.
  /// (Class: int or intString)
  dynamic numberOfMonths;

  /// Corresponds to mainCalendar in pikaday.js.
  /// mainCalendar: isNull ? null : isLeft ? "left" : "right".
  /// When numberOfMonths is used, this will help you to choose
  /// where the main calendar will be (default left, can be set to right).
  /// Only used for the first display or when a selected date is not already visible.
  /// (Class: bool or boolString)
  dynamic mainCalendarIsLeft;

  /// Corresponds to the parameter with the same name in pikaday.js.
  /// Define a classname that can be used as a hook for styling different themes.
  /// Defaults to null.
  String theme;

  Map<String, dynamic> asMap() {
    int strToIntOrNull(String intStr) {
      return int.parse(intStr, onError: (_)=>null);
    }
    int toIntOrNull(var value) {
      if(value is int) {
        return value;
      }
      if(value is String) {
        return strToIntOrNull(value);
      }
      return null;
    }

    bool toBoolOrNull(var value) {
      if(value is bool) {
        return value;
      }
      if(value is String) {
        if(value=="true") {
          return true;
        }
        if(value=="false") {
          return false;
        }
      }
      return null;
    }

    DateTime toDayOrNull(var value) {
      if(value is DateTime) {
        return value;
      }
      if(value is String) {
        // assume format "yyyy-mm-dd"
        // allow format "yyyy-mm-dd hh:mm:ss"
        List<String> dateParts = value.trim().split(" ")[0].split("-");
        if(dateParts.length==3) {
          int year  = strToIntOrNull(dateParts[0]);
          int month = strToIntOrNull(dateParts[1]);
          int day   = strToIntOrNull(dateParts[2]);
          if(year!=null && month!=null && day!=null) {
            return new DateTime(year, month, day);
          }
        }
      }
      return null;
    }

    Map<String, dynamic> params = {};

    if (defaultDay != null) {
      params['defaultDate'] = defaultDay;
      params['setDefaultDate'] = toBoolOrNull(showDayOnInit);
    }
    if (bound != null) {
      params['bound'] = toBoolOrNull(bound);
    }
    if (position != null) {
      params['position'] = position;
    }
    if (reposition != null) {
      params['reposition'] = toBoolOrNull(reposition);
    }
    if (format != null) {
      params['format'] = format;
    }
    if (formatString != null) {
      params['formatString'] = toBoolOrNull(formatString);
    }
    if (firstDay != null) {
      params['firstDay'] = toIntOrNull(firstDay);
    }
    if (minDate != null) {
      params['minDate'] = toDayOrNull(minDate);
    }
    if (maxDate != null) {
      params['maxDate'] = toDayOrNull(maxDate);
    }
    if (disableWeekends != null) {
      params['disableWeekends'] = toBoolOrNull(disableWeekends);
    }
    if (yearRange != null) {
      // yearRange is either number of years on either side (e.g. 10)
      // or array of upper/lower range (e.g. [1900,2015]).
      if(yearRange is int) {
        params['yearRange'] = yearRange;
      } else if (yearRange is List && yearRange.length == 2) {
        dynamic fromYear = yearRange[0];
        dynamic toYear = yearRange[1];
        if(fromYear is int && toYear is int && fromYear <= toYear ) {
          params['yearRange'] = yearRange;
        }
      }
    } else {
      // fall back on the year of minDateStr and maxDateStr
      DateTime minDate = params['minDate'];
      DateTime maxDate = params['maxDate'];
      if(minDate!=null && maxDate!=null &&
          minDate.isBefore(maxDate)) {
        params['yearRange'] = [minDate.year, maxDate.year];
      }
    }
    if (showWeekNumber != null) {
      params['showWeekNumber'] = toBoolOrNull(showWeekNumber);
    }
    if (isRTL != null) {
      params['isRTL'] = toBoolOrNull(isRTL);
    }
    if (i18n != null) {
      params['i18n'] = i18n;
    }
    if (yearSuffix != null) {
      params['yearSuffix'] = yearSuffix;
    }
    if (showMonthAfterYear != null) {
      params['showMonthAfterYear'] = toBoolOrNull(showMonthAfterYear);
    }
    if (showDaysInNextAndPreviousMonths != null) {
      params['showDaysInNextAndPreviousMonths'] =
          toBoolOrNull(showDaysInNextAndPreviousMonths);
    }
    if (numberOfMonths != null) {
      params['numberOfMonths'] = toIntOrNull(numberOfMonths);
    }
    if (mainCalendarIsLeft != null) {
      params['mainCalendarIsLeft'] = toBoolOrNull(mainCalendarIsLeft) ? "left" : "right";
    }
    if (theme != null) {
      params['theme'] = theme;
    }

    return params;
  }
}
