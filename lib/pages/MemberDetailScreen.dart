import 'package:flutter/material.dart';
import 'package:gym/models/MemberModel.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomList.dart';
import 'package:provider/provider.dart';

import '../models/TrainerModel.dart';

class MemberDetailScreen extends StatefulWidget {
  final Member member;
  MemberDetailScreen({super.key, required this.member});

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('D E T A I L S', style: TextStyle(color: Color(0xff720455))),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              CustomList(
                title: [
                  'name',
                  'email',
                  'Contact Number',
                  'age',
                  'gender',
                ],
                subtitle: [
                  widget.member.name,
                  widget.member.email ?? 'Not Set',
                  widget.member.phoneNumber,
                  '${widget.member.age}' ?? 'Not Set',
                  widget.member.gender ?? 'Not Set',
                ],
                onTap: [],
              ),
              SizedBox(height: 16),
              Container(height: 0.5 , width: double.maxFinite,color: Colors.grey,),
              SizedBox(height: 16),
              CustomList(
                title: [
                  'Fee',
                  'Expire Date',
                  'Diet',
                  'Workout',
                  'Trainer Assigned',
                ],
                subtitle: [
                  widget.member.paymentRecords == null ? 'Not paid' :  widget.member.paymentRecords!.isEmpty ? 'Not Paid' :  widget.member.paymentRecords?.last.amount.toString(),
                  widget.member.membershipExpiryDate == null ? 'No Data' : widget.member.membershipExpiryDate?.toIso8601String().substring(0,10),
                  widget.member.diet != null && widget.member.diet!.isNotEmpty
                      ? 'Yes'
                      : 'No',
                  widget.member.workout != null && widget.member.workout!.isNotEmpty
                      ? 'Yes'
                      : 'No',
                  widget.member.trainerId ?? 'N/A',
                ],
                onTap: [
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
