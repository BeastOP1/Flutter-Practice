// import 'package:flutter/material.dart';
// import 'package:flutter_learn/project/presentation/screens/common/components/app_bar_component.dart';
// import 'package:flutter_learn/project/presentation/screens/common/components/bottom_bar_component.dart';
// import 'package:flutter_learn/project/presentation/screens/common/components/class_component.dart';
// import 'package:flutter_learn/project/presentation/screens/assignment/AssignmentUploadScreen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   var items = [
//     NavBarItem(icon: "assets/ic_home.svg", label: "Home"),
//     NavBarItem(icon: "assets/ic_course.svg", label: "Courses"),
//     NavBarItem(icon: "assets/ic_schedule.svg", label: "Schedule"),
//     NavBarItem(icon: "assets/ic_result.svg", label: "Result"),
//     NavBarItem(icon: "assets/ic_student.svg", label: "Profile"),
//   ];
//
//   bool isNewsSelected = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size(double.maxFinite, 70),
//         child: LMSAppBar(userName: "Hassan Farooq Siddiqi", onMenuPress: () {}),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           spacing: 16,
//           children: [
//             _buildCategories(),
//             _buildSectionTitle("Today's Classes", "Open Schedule"),
//             _buildClassesRow(),
//             _buildSectionTitle("Today's Submission", "See All"),
//             _buildSubmissionsRow(),
//             _buildNewsEventsToggle(),
//             isNewsSelected ? _buildNewsCard() : _buildEventsCard(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategories() {
//     final List<Map<String, String>> catData = [
//       {"title": "Computer Science", "img": "assets/images/img_cs.png"},
//       {"title": "IT", "img": "assets/images/img_his.png"},
//       {"title": "Software Engineering", "img": "assets/images/img_soft.png"},
//       {"title": "Cyber Security", "img": "assets/images/img_math.png"},
//     ];
//
//     return SizedBox(
//       height: 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: catData.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: 125,
//
//             margin: EdgeInsets.only(right: 16, left: (index == 0) ? 16 : 0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               image: DecorationImage(
//                 image: AssetImage(catData[index]["img"]!),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.25),
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//             padding: const EdgeInsets.all(10),
//             alignment: Alignment.bottomLeft,
//             child: Text(
//               catData[index]["title"]!,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 11,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildClassesRow() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       // clipBehavior ko none rakha hai taake shadow na katsaky
//       clipBehavior: Clip.none,
//       child: Row(
//         children: [
//           ClassComponent(
//             start: true,
//             themeColor: const Color(0xFF8A2373),
//             title: 'Computer Networks',
//             time: '12:00 - 2:00',
//             num: '1',
//           ),
//
//           ClassComponent(
//             num: "2",
//             title: "Operating Systems",
//             themeColor: Colors.orange,
//             time: "02:00 - 04:00",
//             start: false,
//           ),
//           ClassComponent(
//             num  :"3",
//             title:"Data Structures",
//             themeColor:Colors.blue,
//             time: "04:30 - 06:30",
//            start:  false,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSubmissionsRow() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           _submitCard("Computer Networks", const Color(0xFF8A2373), true),
//           _submitCard("Operating System", Colors.lightGreen, false),
//           _submitCard("Mathematics", Colors.orange, false),
//         ],
//       ),
//     );
//   }
//
//   Widget _submitCard(String title, Color themeColor, bool start) {
//     return GestureDetector(
//       onTap: () {
//         // Navigation Logic
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AssignmentUploadScreen(title: title),
//           ),
//         );
//       },
//       child: Container(
//         width: 155,
//         height: 135,
//         margin: EdgeInsets.only(right: 16, bottom: 16, left: start ? 16 : 0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: themeColor.withOpacity(0.15),
//               blurRadius: 15,
//               offset: const Offset(0, 8),
//               spreadRadius: -2,
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: themeColor,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               child: Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 children: [
//                   _submissionDetailItem(
//                     Icons.copy_rounded,
//                     "Assignment #08",
//                     themeColor,
//                   ),
//                   const SizedBox(height: 8),
//                   _submissionDetailItem(
//                     Icons.person_outline_rounded,
//                     "Sir Ali",
//                     themeColor,
//                   ),
//                   const SizedBox(height: 8),
//                   _submissionDetailItem(
//                     Icons.timer_outlined,
//                     "12 Hours Left",
//                     themeColor,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _submissionDetailItem(IconData icon, String text, Color color) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: color),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text(
//             text,
//             style: const TextStyle(
//               fontSize: 11,
//               color: Color(0xFF1D2939),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNewsEventsToggle() {
//     return
//       Container(
//         width: 150,
//         margin: EdgeInsetsGeometry.symmetric(horizontal: 16),
//         padding: EdgeInsetsGeometry.all(8),
//         decoration: BoxDecoration(
//           border: BoxBorder.all(color: Color(0xffe9eae9)),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Row(
//           spacing: 8,
//           children: [
//             _toggleBtn(
//               "News",
//               isNewsSelected,
//                   () => setState(() => isNewsSelected = true),
//             ),
//             _toggleBtn(
//               "Events",
//               !isNewsSelected,
//                   () => setState(() => isNewsSelected = false),
//             ),
//           ],
//         ),
//       );
//
//   }
//
//   Widget _toggleBtn(String text, bool active, VoidCallback tap) {
//     return GestureDetector(
//       onTap: tap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: active ? const Color(0xFF8A2373) : Colors.grey[100],
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: active ? Colors.white : Colors.black,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNewsCard() {
//     return Container(
//       margin: EdgeInsetsGeometry.only(left: 16, right: 16, bottom: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFDF4FB),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x358D2072),
//             offset: Offset(0, 2),
//             blurStyle: BlurStyle.outer,
//           ),
//         ],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 6,
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Lorem Ipsum",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF8A2373),
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     "Stay updated with the latest happenings in your campus and abroad.",
//                     style: TextStyle(fontSize: 10, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 10),
//                   _iconText(Icons.location_on, "Islamabad"),
//                   _iconText(Icons.calendar_today, "23 Mar, 2026"),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//               child: Image.asset(
//                 "assets/images/img_news.png",
//                 height: 171,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.image, size: 50, color: Colors.grey),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEventsCard() {
//     return Container(
//       margin: EdgeInsetsGeometry.only(left: 16, right: 16, bottom: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFDF4FB),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x358D2072),
//             offset: Offset(0, 2),
//             blurStyle: BlurStyle.outer,
//           ),
//         ],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 6,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "IDP Study Abroad Expo",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF8A2373),
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     "Stay updated with the latest happenings in your campus and abroad.",
//                     style: TextStyle(fontSize: 10, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 10),
//                   _iconText(Icons.location_on, "Islamabad"),
//                   _iconText(Icons.calendar_today, "23 Mar, 2026"),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//               child: Image.asset(
//                 "assets/images/img_events.png",
//                 height: 170,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.image, size: 50, color: Colors.grey),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title, String action) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Row(
//             children: [
//               Text(
//                 action,
//                 style: const TextStyle(
//                   color: Color(0xFF8A2373),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//                 color: Color(0xFF8A2373),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _iconText(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 15, color: Colors.grey[600]),
//           const SizedBox(width: 6),
//           Text(text, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
//         ],
//       ),
//     );
//   }
// }


// lib/presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_learn/project/data/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learn/project/presentation/providers/auth_provider.dart';
import 'package:flutter_learn/project/presentation/providers/home_provider.dart';
import 'package:flutter_learn/project/presentation/providers/profile_provider.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/app_bar_component.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/class_component.dart';
import 'package:flutter_learn/project/presentation/screens/assignment/AssignmentUploadScreen.dart';
import 'package:flutter_learn/project/data/models/assignment_model.dart';
import 'package:flutter_learn/project/data/models/today_class_model.dart';
import 'package:flutter_learn/project/data/models/news_event_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isNewsSelected = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await ref.read(homeProvider.notifier).loadHomeData();
    await ref.read(profileProvider.notifier).fetchProfile();
  }

  Future<void> _onRefresh() async {
    await ref.read(homeProvider.notifier).loadHomeData(refresh: true);
    await ref.read(profileProvider.notifier).fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final profileState = ref.watch(profileProvider);
    final homeState = ref.watch(homeProvider);

    final userName = profileState.profile?.fullName ??
        authState.profile?.fullName ??
        'Student';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 70),
        child: LMSAppBar(
          userName: userName,
          avatarUrl: profileState.profile?.avatarUrl,
          onMenuPress: () {},
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: const Color(0xFF8A2373),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 16,
            children: [
              // ✅ DYNAMIC: Active enrolled courses as categories
              if (homeState.isLoading && !homeState.isRefreshing)
                _buildLoadingCategories()
              else if (homeState.enrolledCourses.isEmpty)
                _buildEmptyCategories()
              else
                _buildCategories(homeState.enrolledCourses),

              // ✅ DYNAMIC: Today's Classes
              _buildSectionTitle("Today's Classes", "Open Schedule"),
              if (homeState.isLoading && !homeState.isRefreshing)
                _buildLoadingClassCards()
              else if (homeState.todayClasses.isEmpty)
                _buildEmptyClasses()
              else
                _buildClassesRow(homeState.todayClasses),

              // ✅ DYNAMIC: Today's Submissions
              _buildSectionTitle("Today's Submission", "See All"),
              if (homeState.isLoading && !homeState.isRefreshing)
                _buildLoadingSubmissionCards()
              else if (homeState.todayAssignments.isEmpty)
                _buildEmptySubmissions()
              else
                _buildSubmissionsRow(homeState.todayAssignments),

              // News & Events Toggle
              _buildNewsEventsToggle(),

              // ✅ DYNAMIC: News or Events Card
              if (homeState.isLoading && !homeState.isRefreshing)
                _buildLoadingNewsCard()
              else if (homeState.newsEvents.isEmpty)
                _buildEmptyNews()
              else
                isNewsSelected
                    ? _buildNewsCard(homeState.newsEvents)
                    : _buildEventsCard(homeState.newsEvents),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Categories Section (Static - can be made dynamic later) ─────────────
  Widget _buildCategories(List<CourseModel> courses) {
    // Take first 4 courses for horizontal scroll
    final displayCourses = courses.take(4).toList();

    // Default images based on department
    final Map<String, String> departmentImages = {
      'Computer Science': 'assets/images/img_cs.png',
      'IT': 'assets/images/img_his.png',
      'Software Engineering': 'assets/images/img_soft.png',
      'Cyber Security': 'assets/images/img_math.png',
    };

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayCourses.length,
        itemBuilder: (context, index) {
          final course = displayCourses[index];
          final imagePath = course.imageUrl ??
              departmentImages[course.department] ??
              'assets/images/img_cs.png';

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/course/${course.id}',
                arguments: course,
              );
            },
            child: Container(
              width: 125,
              margin: EdgeInsets.only(right: 16, left: (index == 0) ? 16 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: course.imageUrl != null
                    ? DecorationImage(
                  image: NetworkImage(course.imageUrl!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.25),
                    BlendMode.darken,
                  ),
                )
                    : DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.25),
                    BlendMode.darken,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    course.code,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingCategories() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: 125,
            margin: EdgeInsets.only(right: 16, left: (index == 0) ? 16 : 0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyCategories() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              size: 32,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'No courses enrolled',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Dynamic Classes Row ─────────────────────────────────────────────────
  Widget _buildClassesRow(List<TodayClassModel> classes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: classes.asMap().entries.map((entry) {
          final index = entry.key;
          final classItem = entry.value;

          final List<Color> colors = [
            const Color(0xFF8A2373),
            Colors.orange,
            Colors.blue,
            Colors.green,
            Colors.purple,
          ];

          return ClassComponent(
            start: index == 0,
            end: index == classes.length - 1,
            themeColor: colors[index % colors.length],
            title: classItem.courseTitle,
            time: classItem.formattedTime,
            num: (index + 1).toString(),
            location: classItem.locationDisplay,
            instructor: classItem.instructorName,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadingClassCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [1, 2, 3].map((i) {
          return Container(
            margin: EdgeInsets.only(right: 16, left: i == 1 ? 16 : 0),
            width: 192,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: const Color(0xFF8A2373).withOpacity(0.5),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyClasses() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: 40,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'No classes today',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              'Enjoy your free time!',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Dynamic Submissions Row ──────────────────────────────────────────────
  Widget _buildSubmissionsRow(List<AssignmentModel> assignments) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: assignments.asMap().entries.map((entry) {
          final index = entry.key;
          final assignment = entry.value;

          final List<Color> colors = [
            const Color(0xFF8A2373),
            Colors.lightGreen,
            Colors.orange,
            Colors.blue,
          ];

          return _buildSubmissionCard(
            assignment: assignment,
            themeColor: colors[index % colors.length],
            start: index == 0,
          );
        }).toList(),
      ),
    );
  }


  Widget _buildSubmissionCard({
    required AssignmentModel assignment,
    required Color themeColor,
    required bool start,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentUploadScreen(
              title: assignment.title,
              assignmentId: assignment.id,
            ),
          ),
        );
      },
      child: Container(
        width: 155,
        height: 135,
        margin: EdgeInsets.only(right: 16, bottom: 16, left: start ? 16 : 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: themeColor.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Text(
                assignment.courseCode, // ✅ Course code instead of title
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _submissionDetailItem(
                    Icons.copy_rounded,
                    assignment.title.length > 12
                        ? '${assignment.title.substring(0, 12)}...'
                        : assignment.title,
                    themeColor,
                  ),
                  const SizedBox(height: 8),
                  _submissionDetailItem(
                    Icons.timer_outlined,
                    assignment.timeLeft,
                    assignment.statusColor,
                  ),
                  const SizedBox(height: 8),
                  _submissionDetailItem(
                    assignment.isSubmitted
                        ? Icons.check_circle
                        : Icons.pending_actions,
                    assignment.statusText,
                    assignment.statusColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLoadingSubmissionCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [1, 2, 3].map((i) {
          return Container(
            width: 155,
            height: 135,
            margin: EdgeInsets.only(right: 16, left: i == 1 ? 16 : 0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptySubmissions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 40,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'No submissions due today',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              'You\'re all caught up!',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submissionDetailItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // ─── News & Events Section ───────────────────────────────────────────────
  Widget _buildNewsEventsToggle() {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffe9eae9)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        spacing: 8,
        children: [
          _toggleBtn(
            "News",
            isNewsSelected,
                () => setState(() => isNewsSelected = true),
          ),
          _toggleBtn(
            "Events",
            !isNewsSelected,
                () => setState(() => isNewsSelected = false),
          ),
        ],
      ),
    );
  }

  Widget _toggleBtn(String text, bool active, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF8A2373) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(List<NewsEventModel> newsEvents) {
    final newsItems = newsEvents.where((item) => item.isNews).toList();
    if (newsItems.isEmpty) return _buildEmptyNews();

    // ✅ Show ALL news in a horizontal list instead of just first one
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: newsItems.asMap().entries.map((entry) {
          final index = entry.key;
          final news = entry.value;

          return Container(
            width: 320,
            margin: EdgeInsets.only(
              right: 16,
              left: index == 0 ? 16 : 0,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF4FB),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x358D2072),
                  offset: const Offset(0, 2),
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8A2373),
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          news.content,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        _iconText(Icons.calendar_today, news.formattedDate),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: news.imageUrl != null
                        ? Image.network(
                      news.imageUrl!,
                      height: 171,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            "assets/images/img_news.png",
                            height: 171,
                            fit: BoxFit.cover,
                          ),
                    )
                        : Image.asset(
                      "assets/images/img_news.png",
                      height: 171,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEventsCard(List<NewsEventModel> newsEvents) {
    final eventItems = newsEvents.where((item) => item.isEvent).toList();
    if (eventItems.isEmpty) return _buildEmptyEvents();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: eventItems.asMap().entries.map((entry) {
          final index = entry.key;
          final event = entry.value;

          return Container(
            width: 320,
            margin: EdgeInsets.only(
              right: 16,
              left: index == 0 ? 16 : 0,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF4FB),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x358D2072),
                  offset: const Offset(0, 2),
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8A2373),
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          event.content,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        _iconText(Icons.calendar_today, event.formattedDate),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: event.imageUrl != null
                        ? Image.network(
                      event.imageUrl!,
                      height: 170,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            "assets/images/img_events.png",
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                    )
                        : Image.asset(
                      "assets/images/img_events.png",
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadingNewsCard() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      height: 171,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: const Color(0xFF8A2373).withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildEmptyNews() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.newspaper,
              size: 40,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'No news available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyEvents() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.event,
              size: 40,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'No events scheduled',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helper Widgets ──────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to respective screen
              if (title.contains("Classes")) {
                Navigator.pushNamed(context, '/schedule');
              } else if (title.contains("Submission")) {
                Navigator.pushNamed(context, '/assignments');
              }
            },
            child: Row(
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    color: Color(0xFF8A2373),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF8A2373),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 15, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
        ],
      ),
    );
  }
}