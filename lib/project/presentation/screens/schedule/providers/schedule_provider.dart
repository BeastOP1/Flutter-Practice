// import 'package:flutter/foundation.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../models/class_model.dart';
//
// class ScheduleProvider extends ChangeNotifier {
//   DateTime _focusedMonth = DateTime.now();
//   DateTime get focusedMonth => _focusedMonth;
//
//   List<ClassModel> _todayClasses = [];
//   List<ClassModel> get todayClasses => _todayClasses;
//
//   Map<String, List<ClassModel>> _scheduleCache = {};
//   Map<String, List<ClassModel>> get scheduleCache => _scheduleCache; // Added getter
//
//   int _totalNotifications = 0;
//   int get totalNotifications => _totalNotifications;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading; // Added loading state
//
//   void changeMonth(int delta) {
//     _focusedMonth = DateTime(
//       _focusedMonth.year,
//       _focusedMonth.month + delta,
//     );
//     loadClassesForMonth(_focusedMonth); // Made public
//     notifyListeners();
//   }
//
//   void selectDate(DateTime date) {
//     _loadClassesForDate(date);
//     notifyListeners();
//   }
//
//   // Made public so Screen can call it
//   Future<void> loadClassesForMonth(DateTime month) async {
//     _isLoading = true;
//     notifyListeners();
//
//     // Simulate API call
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     // Mock data - Replace with actual API call
//     final mockClasses = _generateMockClasses(month);
//     _scheduleCache = mockClasses;
//
//     // Update today's classes if applicable
//     final today = DateTime.now();
//     final todayKey = '${today.year}-${today.month}-${today.day}';
//     _todayClasses = _scheduleCache[todayKey] ?? [];
//
//     _updateNotificationCount();
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   void _loadClassesForDate(DateTime date) {
//     _isLoading = true;
//     notifyListeners();
//
//     final key = '${date.year}-${date.month}-${date.day}';
//     _todayClasses = _scheduleCache[key] ?? [];
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   void _updateNotificationCount() {
//     _totalNotifications = _todayClasses
//         .where((c) => c.hasNotification)
//         .fold(0, (sum, c) => sum + c.notificationCount);
//   }
//
//   Map<String, List<ClassModel>> _generateMockClasses(DateTime month) {
//     // Mock data generation - Replace with actual data source
//     return {
//       '${month.year}-${month.month}-20': [
//         ClassModel(
//           id: '1',
//           title: 'Computer Networks',
//           time: '12:00 - 2:00',
//           roomNumber: 'Room No 25',
//           instructor: 'Dr. Smith',
//           startTime: DateTime(month.year, month.month, 20, 12, 0),
//           endTime: DateTime(month.year, month.month, 20, 14, 0),
//           themeColor: AppColors.classCardColors[0],
//           hasNotification: true,
//           notificationCount: 2,
//         ),
//         ClassModel(
//           id: '2',
//           title: 'Data Structures',
//           time: '2:00 - 4:00',
//           roomNumber: 'Room No 30',
//           instructor: 'Dr. Johnson',
//           startTime: DateTime(month.year, month.month, 20, 14, 0),
//           endTime: DateTime(month.year, month.month, 20, 16, 0),
//           themeColor: AppColors.classCardColors[1],
//           hasNotification: true,
//           notificationCount: 1,
//         ),
//       ],
//       '${month.year}-${month.month}-21': [
//         ClassModel(
//           id: '3',
//           title: 'Database Systems',
//           time: '10:00 - 12:00',
//           roomNumber: 'Room No 15',
//           instructor: 'Dr. Williams',
//           startTime: DateTime(month.year, month.month, 21, 10, 0),
//           endTime: DateTime(month.year, month.month, 21, 12, 0),
//           themeColor: AppColors.classCardColors[2],
//           hasNotification: false,
//           notificationCount: 0,
//         ),
//       ],
//     };
//   }
// }