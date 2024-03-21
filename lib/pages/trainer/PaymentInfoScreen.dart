import 'package:flutter/material.dart';
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

  void setData(){
    print('set data from payment info screen of trainer');
    String gymCode  = Provider.of<TrainerProvider>(context,listen: false).trainer.gymCode ?? '';
    Provider.of<MemberProvider>(context,listen: false).fetchMembersByGymCode(gymCode);
  }

  @override
  void initState() {
    setData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Payments'),
      ),
      body: SafeArea(
        child: Consumer<MemberProvider>(
          builder: (context, memberProvider, _) {
            // Get the list of members from the provider
            List<Member> members = memberProvider.members;

            // Here you can decide how to display the information.
            // For demonstration, I'm using a ListView.builder to display each member's information.
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                Member member = members[index];
                return CustomListTile(
                  title: '${member.name}',
                  subtitle: '${member.phoneNumber}',
                  showToggle: true,
                  toggleValue: _paymentStatus(member),
                  onToggle: (bool){
                  },
                );
              },
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
