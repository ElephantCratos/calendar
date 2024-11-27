import 'package:flutter/material.dart';

import '../services/calendar_service.dart';
import '../widgets/navigation_buttons.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();

  void _changeMonth(int direction) {
    setState(() {
      _currentDate = DateTime(
        _currentDate.year,
        _currentDate.month + direction,
      );
    });
  }

  void _goToToday() {
    setState(() {
      _currentDate = DateTime.now();
    });
  }

  void _changeYear(int direction) {
    setState(() {
      _currentDate = DateTime(
        _currentDate.year + direction,
        _currentDate.month,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    final days =
        CalendarService.getDaysInMonth(_currentDate.year, _currentDate.month);
    final firstWeekday = days.first.weekday;
    final offsetDays = List.generate(firstWeekday - 1, (_) => null);
    final allDays = [...weekDays, ...offsetDays, ...days];
    final isCurrentMonth = _currentDate.year == DateTime.now().year &&
        _currentDate.month == DateTime.now().month;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
        centerTitle: true,
        actions: [
           if (!isCurrentMonth)
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: _goToToday,
            ),
        ],
      ),
      body: Column(
        children: [
          NavigationButtons(
            currentDate: _currentDate,
            onChangeMonth: _changeMonth,
            onChangeYear: _changeYear,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: allDays.length,
              itemBuilder: (context, index) {
                final item = allDays[index];

                if (item is String) {
                  return Center(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  );
                }

                final day = item as DateTime?;

                final isToday = day != null &&
                    day.year == DateTime.now().year &&
                    day.month == DateTime.now().month &&
                    day.day == DateTime.now().day;

                return Center(
                  child: day != null
                      ? Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isToday ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                color: isToday ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
