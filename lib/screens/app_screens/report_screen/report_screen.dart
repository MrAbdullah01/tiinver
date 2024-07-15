import 'package:flutter/material.dart';
import 'package:tiinver_project/constants/colors.dart';
import 'package:tiinver_project/widgets/header.dart';

import '../other_user_profile_screen/comp/dialogue_box.dart';
import 'comp/report_tile.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: Header().header1("Report",
          [],
          isCenterTitle: true,
          isIconShow: true),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [

            ReportTile(
              title: "Nudity",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content"
                            "related to Nudity",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

            ReportTile(
              title: "Violence",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content"
                            "releated to Violence",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

            ReportTile(
              title: "Harassment",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content"
                            "releated to Hurasment",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

            ReportTile(
              title: "False Information",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content"
                            "releated to False Information",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

            ReportTile(
              title: "Unauthorized Sales",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content"
                            "releated to Uthorized_Sales",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

            ReportTile(
              title: "Hate Speech",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content"
                            "releated to Hate Speech",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

            ReportTile(
              title: "Terrorism",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content"
                            "releated to Terrorism",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

            ReportTile(
              title: "Under 13 years old",
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueBox().customDialogue(
                        context,
                        title: "Report Reminder ?",
                        subTitle: "I am reporting this user for posting content "
                            "releated to Under 13 years old",
                        primaryButtonText: "Report",
                        primaryTap: (){}
                    );
                  },);
              },
            ),

          ],
        ),
      ),
    );
  }
}
