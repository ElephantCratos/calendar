import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/calendar_service.dart';

class NavigationButtons extends StatelessWidget {
  final DateTime currentDate;
  final Function(int) onChangeMonth;
  final Function(int) onChangeYear;

  const NavigationButtons({
    super.key,
    required this.currentDate,
    required this.onChangeMonth,
    required this.onChangeYear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => onChangeMonth(-1),
        ),
        Column(
          children: [
            Text(
              '${CalendarService.monthToRussian(DateFormat.MMMM().format(currentDate))} ${currentDate.year}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => onChangeYear(-1),
                  tooltip: 'Уменьшить год',
                ),
                Text(
                  '${currentDate.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => onChangeYear(1),
                  tooltip: 'Увеличить год',
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () => onChangeMonth(1),
        ),
      ],
    );
  }
}
