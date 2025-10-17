DateTime startOfToday() {
  final d = DateTime.now();
  return DateTime(d.year, d.month, d.day);
}
DateTime endOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 23, 59, 59, 999);
DateTime addDays(DateTime base, int n) => base.add(Duration(days: n));

bool matchesDateScope(String isoDate, String scope, {String? exact}) {
  if (exact != null && exact.isNotEmpty) {
    final eq = DateTime.parse(exact).toLocal();
    final d = DateTime.parse(isoDate).toLocal();
    return DateTime(d.year, d.month, d.day) == DateTime(eq.year, eq.month, eq.day);
  }
  if (scope == 'all') return true;

  final today0 = startOfToday();
  final d = DateTime.tryParse(isoDate)?.toLocal();
  if (d == null) return false;

  bool inFuture(DateTime x, int days) =>
      x.isAfter(today0.subtract(const Duration(milliseconds: 1))) &&
      x.isBefore(endOfDay(addDays(today0, days)).add(const Duration(milliseconds: 1)));

  switch (scope) {
    case 'today':
      return DateTime(d.year, d.month, d.day) == today0;
    case 'tomorrow':
      final t1 = addDays(today0, 1);
      return DateTime(d.year, d.month, d.day) == t1;
    case 'week':
      return inFuture(d, 7);
    case 'month':
      return inFuture(d, 30);
    case 'year':
      return inFuture(d, 365);
    default:
      return true;
  }
}
