//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    this.restorationId,
    required this.onChange,
    required this.child,
  });

  final String? restorationId;
  final Function(DateTime) onChange;
  final Widget child;
  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> with RestorationMixin {
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static ThemeData getThemeData(ThemeData theme) {
    return theme.copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight, // header background color
        onPrimary: Colors.black, // header text color
        onSurface: Colors.black, // body text color
        surface: Color(0xFFEFE9F5),
        background: Colors.orange,
      ),
      dialogBackgroundColor: const Color(0xFFEFE9F5),
    );
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: getThemeData(Theme.of(context)),
          child: DatePickerDialog(
            restorationId: 'date_picker_dialog',
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
            firstDate: DateTime(1980),
            lastDate: DateTime(DateTime.now().year + 1),
          ),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        widget.onChange(newSelectedDate);
      });
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: widget.child,
    );
  }
}

class DatePickerBubble extends StatelessWidget {
  DatePickerBubble({
    super.key,
    required DateTime selectedDate,
  }) : _selectedDate = selectedDate;

  final DateTime _selectedDate;
  final formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      // alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.translate.date,
            style: Topology.subTitle.copyWith(
              height: 2.2,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            formatter.format(_selectedDate),
            style: Topology.subTitle.copyWith(
              height: 2.5,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_drop_down,
            size: 32,
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
