import 'package:amazone_clone/features/account/widgets/single_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SingleButton(
              buttonName: "Your Orders",
              voidCallback: () {},
            ),
            SingleButton(
              buttonName: "Turn Seller",
              voidCallback: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SingleButton(
              buttonName: "Log Out",
              voidCallback: () {},
            ),
            SingleButton(
              buttonName: "Your Wish List",
              voidCallback: () {},
            ),
          ],
        )
      ],
    );
  }
}
