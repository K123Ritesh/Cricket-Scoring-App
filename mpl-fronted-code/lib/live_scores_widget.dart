import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveScoresWidget extends StatefulWidget {
  const LiveScoresWidget({super.key, required this.matchTime});
  final String matchTime;

  @override
  State<LiveScoresWidget> createState() => _LiveScoresWidgetState();
}

class _LiveScoresWidgetState extends State<LiveScoresWidget> {
  final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get stream => _controller.stream;

  @override
  void initState() {
    super.initState();
    fetchDataPeriodically(); // Fetch data periodically using a timer
  }

  void fetchDataPeriodically() {
    const Duration fetchInterval =
        Duration(seconds: 1); // Adjust interval as needed

    Timer.periodic(fetchInterval, (Timer timer) async {
      try {
        final response = await http.get(
          Uri.parse('https://mpl-backend-92m8.onrender.com/live-scores-today'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          _controller.add(data);
          print(data);
        } else {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Map<String, dynamic> liveScoresData = snapshot.data!;
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                  height: 150.h,
                  width: 330.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.white)),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              widget.matchTime == "first"
                                  ? liveScoresData["first"]["team1"]
                                  : liveScoresData["second"]["team1"],
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 156, 210, 255),
                                  fontSize: 20.sp)),
                          Text(
                            widget.matchTime == "first"
                                ? liveScoresData["first"]["team1_score"]
                                : liveScoresData["second"]["team1_score"],
                            style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 156, 210, 255),
                                fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              widget.matchTime == "first"
                                  ? liveScoresData["first"]["team2"]
                                  : liveScoresData["second"]["team2"],
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 156, 210, 255),
                                  fontSize: 20.sp)),
                          Text(
                            widget.matchTime == "first"
                                ? liveScoresData["first"]["team2_score"]
                                : liveScoresData["second"]["team2_score"],
                            style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 156, 210, 255),
                                fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                    Text(
                      liveScoresData["first"]["message"],
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp, color: Colors.orange),
                    )
                  ])));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(
              child: Container(
                  height: 150.h,
                  width: 330.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.white)),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ))));
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
