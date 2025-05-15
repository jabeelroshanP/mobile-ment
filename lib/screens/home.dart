import 'package:flutter/material.dart';
import 'package:mobilement/Widgets/appBar.dart';
import 'package:mobilement/Widgets/barchart.dart';
import 'package:mobilement/Widgets/container.dart';
import 'package:mobilement/constants/colors.dart';
import 'package:mobilement/constants/text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBluePurple,
        appBar: customAppBar([
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_sharp,
              color: Colors.white70,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF61DAFB),
              child: Icon(
                Icons.person,
                color: Color(0xFF1E1E2E),
                size: 20,
              ),
            ),
          ),
        ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  TextConsts.techDashBoard,
                  style: TextStyle(
                    color: AppColors.whiteClr,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              homeContainers(),
              homeContainers(),
            ],
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              homeContainers(),
              homeContainers(),
            ],
           ),

              SizedBox(height: 20,),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 538,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.darkBluePurple, AppColors.justSample],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConsts.revenueAndCompledtedBookings, 
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.whiteClr,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          TextConsts.monthlyRevenueAndbookingCount,
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 153, 153),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 380,
                          child: CustomBarChart(
                            monthlyData: {
                              "Jan": {"Revenue": 80, "Completed": 55},
                              "Feb": {"Revenue": 90, "Completed": 60},
                              "Mar": {"Revenue": 30, "Completed": 25},
                              "Apr": {"Revenue": 30, "Completed": 5},
                            },
                            colors: [
                              AppColors.greenGraph,
                              AppColors.pinkGraph,
                            ],
                            metrics: ["Revenue", "Completed"],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
