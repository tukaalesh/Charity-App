// // ignore_for_file: non_constant_identifier_names

// import 'package:charity_app/constants/const_appBar.dart';
// import 'package:charity_app/constants/const_image.dart';
// import 'package:charity_app/feature/volunteer%20projects/cubit/join_to_project/join_to_project_cubit.dart';
// import 'package:charity_app/feature/volunteer%20projects/cubit/join_to_project/join_to_project_states.dart';
// import 'package:charity_app/feature/volunteer%20projects/widget/button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class ProjectDetailsScreen extends StatelessWidget {
//   const ProjectDetailsScreen({
//     super.key,
//     required this.isDark,
//     required this.screenWidth,
//     required this.name,
//     required this.colorScheme,
//     required this.description,
//     required this.required_tasks,
//     required this.id,
//     required this.volunteer_hours,
//     required this.location,
//     required this.total_amount,
//   });

//   final bool isDark;
//   final double screenWidth;
//   final String name;
//   final ColorScheme colorScheme;
//   final String description;
//   final String required_tasks;
//   final int id;
//   final String location;
//   final String volunteer_hours;
//   final int total_amount;

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: const ConstAppBar(title: "التفاصيل الخاصة بالمشروع"),
//         backgroundColor: colorScheme.surface,
//         body: BlocConsumer<JoinToProjectCubit, JoinToProjectStates>(
//           listener: (context, state) {
//             if (state is JoinToProjectSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("تم إرسال طلب التطوع بنجاح!")),
//               );
//             }
//             if (state is JoinToProjectNoSurvey) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   duration: const Duration(seconds: 5),
//                   content: const Text(
//                       "يرجى تعبئة استبيان التطوع قبل الانضمام للمشاريع."),
//                   action: SnackBarAction(
//                     label: 'فتح الاستبيان',
//                     onPressed: () {
//                       Navigator.pushNamed(context, 'VolunteerForm');
//                     },
//                   ),
//                 ),
//               );
//             }
//             if (state is JoinToProjectAlreadyApplied) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text(
//                         "عذراً، لا يمكن الانضمام لهذا المشروع حالياً بسبب تطوعك في مشروع آخر.")),
//               );
//             }
//             if (state is JoinToProjectPendingApproval) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text(
//                         "لا يزال طلب التطوع خاصتك قيد الدراسة، يمكنك البدء بالتطوع عندما يتم قبول طلبك")),
//               );
//             }
//             if (state is JoinToProjectFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("حدث خطأ، حاول لاحقاً.")),
//               );
//             }
//           },
//           builder: (context, state) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 child: ListView(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: SizedBox(
//                         width: screenWidth * 0.36,
//                         height: screenWidth * 0.36,
//                         child: charityLogoImage,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             name,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             description,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: colorScheme.onSurface,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Wrap(
//                             children: [
//                               Text(
//                                 "المهام المطلوبة: ",
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               Text(
//                                 "$required_tasks",
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Wrap(
//                             children: [
//                               Text(
//                                 "الموقع:",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "$location",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w300,
//                               fontSize: 14,
//                               color: colorScheme.onSurface,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: state is JoinToProjectLoding
//                             ? Center(
//                                 child: SpinKitCircle(
//                                 color: colorScheme.secondary,
//                                 size: 45,
//                               ))
//                             : Button(
//                                 buttonText: "تطوع الآن",
//                                 onPressed: () {
//                                   context
//                                       .read<JoinToProjectCubit>()
//                                       .joinToProject(id: id);
//                                 },
//                                 color: colorScheme.secondary,
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
