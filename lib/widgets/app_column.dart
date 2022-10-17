import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double size;

  const AppColumn({Key? key, required this.text, this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: size == 0 ? Dimensions.font20 : size,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        //comments section
        Row(
          children: [
            Wrap(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: AppColors.mainColor,
                          size: 15,
                        ))),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "4.5"),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "1287"),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "Comments"),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        //time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconAndTextWidget(
              text: "Normal",
              iconColor: AppColors.iconColor1,
              icon: Icons.circle,
            ),
            IconAndTextWidget(
                text: "1.7 KM",
                iconColor: AppColors.mainColor,
                icon: Icons.location_pin),
            IconAndTextWidget(
                text: "32 KM",
                iconColor: AppColors.yellowColor,
                icon: Icons.watch_later_outlined)
          ],
        ),
      ],
    );
  }
}
