import 'package:flutter/material.dart';
import 'package:gym/models/TrainerModel.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:provider/provider.dart';

import '../../models/MemberModel.dart';
import '../../providers/TrainerProvider.dart';
import '../../widgets/custom_list_tile.dart';

class PaymentInfoScreen extends StatefulWidget {
  const PaymentInfoScreen({Key? key}) : super(key: key);

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  void setData() {
    print('set data from payment info screen of trainer');
    String gymCode =
        Provider.of<TrainerProvider>(context, listen: false).trainer.gymCode ??
            '';
    Provider.of<MemberProvider>(context, listen: false)
        .fetchMembersByGymCode(gymCode);
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'P A Y M E N T S',
          style: TextStyle(color: Color(0xff720455)),
        ),
      ),
      body: SafeArea(
        child: Consumer<TrainerProvider>(
          builder: (context, trainerProvider, _) {
            return (trainerProvider.trainer.canUpdatePaymentStatus ?? false)
                ? Consumer<MemberProvider>(
              builder: (context, memberProvider, _) {
                List<Member> members = memberProvider.members;
                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    Member member = members[index];
                    return CustomListTile(
                      title: '${member.name}',
                      subtitle: '${member.phoneNumber}',
                      showToggle: true,
                      toggleValue: _paymentStatus(member),
                      onToggle: (bool) {},
                    );
                  },
                );
              },
            )
                : Center(
              child: Text(
                'YOU DON\'T HAVE THIS ACCESS',
                style: TextStyle(
                  color: Color(0xff1d1160),
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  bool _paymentStatus(Member member) {
    if (member.paymentRecords != null && member.paymentRecords!.isNotEmpty) {
      DateTime lastPaymentExpiryDate = member.paymentRecords!.last.expireDate;
      if (lastPaymentExpiryDate.isAfter(DateTime.now())) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
