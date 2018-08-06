# Changelog

## 3.0.1 - 2018-08-06

- downgraded minimum dart-sdk from 2.0.0 to 2.0.0-dev.69.3 because that is the version pub.dartlang.org currently employs
to check packages.

## 3.0.0 - 2018-08-06

- upgraded to Dart2
- upgraded to moment.js 2.22.2
- upgraded to pikaday.js 1.7.0

## 2.0.0 - 2017-02-26

- moved the angular2 part into it's own package (pikaday_datepicker_angular2),
 so that users of the vanilla dart version (this package) won't have to deal
 with the angular2 sources/transformers.

## 1.0.0 - 2017-01-21

- refactored out a plain old Dart Wrapper around Pikaday that can be used independently of the Angular2 Component.

## 0.8.7 - 2017-01-17

- README.md: fixed Usage section a little more and added a Common Problems section.

## 0.8.6 - 2017-01-06

- README.md: fixed Usage section

## 0.8.5 - 2016-12-16

- fixed angular transformer configuration (again, as in 0.8.3)

## 0.8.4 - 2016-12-16

- added placeholder attribute to Pikaday-inputfield 

## 0.8.3 - 2016-12-16

- fixed angular transformer configuration. This package is finally importable.

## 0.8.0 - 2016-12-14

- initial version of the PikadateComponent