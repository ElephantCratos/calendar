class CalendarService {
  
  static List<DateTime> getDaysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(year, month, index + 1),
    );
  }

  //Не хотелось тянуть пакет, ради того, чтобы перевести только месяцы
  //Так что пусть будет так
  static String monthToRussian(String month) {
    const monthMap = {
      'January': 'Январь',
      'February': 'Февраль',
      'March': 'Март',
      'April': 'Апрель',
      'May': 'Май',
      'June': 'Июнь',
      'July': 'Июль',
      'August': 'Август',
      'September': 'Сентябрь',
      'October': 'Октябрь',
      'November': 'Ноябрь',
      'December': 'Декабрь',
    };
    return monthMap[month] ?? month;
  }
}
