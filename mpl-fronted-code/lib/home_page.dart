import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpl/live_scores_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isLoadingdata = true;
  Map<String, dynamic>? data;
  fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://mpl-backend-92m8.onrender.com/api/match'),
      );

      if (response.statusCode == 200) {
        data = json.decode(response.body);

        print(data);
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    setState(() {
      isLoadingdata = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "Welcome to MPL App",
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 25.sp),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "Today's Match",
                  style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  LiveScoresWidget(matchTime: "first"),
                  LiveScoresWidget(
                    matchTime: "second",
                  )
                  // for (int i = 0; i < 2; i++)
                  //   Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                  //     child: Container(
                  //       height: 150.h,
                  //       width: 330.w,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20.r),
                  //           border: Border.all(color: Colors.white)),
                  //       child: Column(
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 18.w, vertical: 10.h),
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text('Titans 11',
                  //                     style: GoogleFonts.poppins(
                  //                         color: const Color.fromARGB(
                  //                             255, 156, 210, 255),
                  //                         fontSize: 20.sp)),
                  //                 Text(
                  //                   '112-2(10)',
                  //                   style: GoogleFonts.poppins(
                  //                       color: const Color.fromARGB(
                  //                           255, 156, 210, 255),
                  //                       fontSize: 20.sp),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 18.w, vertical: 10.h),
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text('RCB',
                  //                     style: GoogleFonts.poppins(
                  //                         color: const Color.fromARGB(
                  //                             255, 156, 210, 255),
                  //                         fontSize: 20.sp)),
                  //                 Text(
                  //                   '112-2(10)',
                  //                   style: GoogleFonts.poppins(
                  //                       color: const Color.fromARGB(
                  //                           255, 156, 210, 255),
                  //                       fontSize: 20.sp),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //           Text(
                  //             "Titans 11 opt to bowl",
                  //             style: GoogleFonts.poppins(
                  //                 fontSize: 20.sp, color: Colors.orange),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "Points Table",
                  style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15.r)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('Rank',
                                style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Team',
                              style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('Win',
                                style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('Loss',
                                style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400)),
                          )),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('Points',
                                style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400)),
                          )),
                    ],
                  ),
                  if (!isLoadingdata)
                    for (int i = 0; i < data!["pointsTable"].length; i++)
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            width: 700.w,
                            height: 0.5.h,
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text('${i + 1}.',
                                        style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400)),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      data!["pointsTable"][i]["team"],
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                        "${data!["pointsTable"][i]["win"]}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400)),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                        "${data!["pointsTable"][i]["lost"]}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400)),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                        "${data!["pointsTable"][i]["points"]}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400)),
                                  )),
                            ],
                          ),
                        ],
                      ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "Top Batters of MPL",
                  style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Column(
              children: [
                for (int i = 0; i < data!["topBatters"].length; i++)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.person,
                            color: Colors.red,
                            size: 45.h,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data!["topBatters"][i]["name"],
                              style: GoogleFonts.poppins(fontSize: 20.sp),
                            ),
                            Text(
                              'Team - ${data!["topBatters"][i]["teamName"]}',
                              style: GoogleFonts.poppins(
                                  color: Colors.red, fontSize: 15.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Row(
                            children: [
                              Text("${data!["topBatters"][i]["score"]} Runs",
                                  style: GoogleFonts.poppins(
                                    color: Colors.green,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "Top Ballers of MPL",
                  style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Column(
              children: [
                for (int i = 0; i < data!["topBowlers"].length; i++)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.person,
                            color: Colors.red,
                            size: 45.h,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data!["topBowlers"][i]["name"],
                              style: GoogleFonts.poppins(fontSize: 20.sp),
                            ),
                            Text(
                              'Team - ${data!["topBowlers"][i]["teamName"]}',
                              style: GoogleFonts.poppins(
                                  color: Colors.red, fontSize: 15.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Row(
                            children: [
                              Text(
                                  "${data!["topBowlers"][i]["wickets"]} Wickets",
                                  style: GoogleFonts.poppins(
                                    color: Colors.green,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
