import 'package:flutter/material.dart';
import 'package:flutter_apptask/ui/general/colors.dart';

Widget hdivider3() => const SizedBox(
      height: 3,
    );
Widget hdivider6() => const SizedBox(
      height: 6,
    );
Widget hdivider10() => const SizedBox(
      height: 10,
    );
Widget hdivider20() => const SizedBox(
      height: 20,
    );
Widget hdivider30() => const SizedBox(
      height: 30,
    );
Widget hdivider40() => const SizedBox(
      height: 40,
    );
Widget hdivider50() => const SizedBox(
      height: 50,
    );

Widget wdivider3() => const SizedBox(
      width: 3,
    );
Widget wdivider6() => const SizedBox(
      width: 6,
    );
Widget wdivider10() => const SizedBox(
      width: 10,
    );
Widget wdivider20() => const SizedBox(
      width: 20,
    );
Widget wdivider30() => const SizedBox(
      width: 30,
    );
Widget wdivider40() => const SizedBox(
      width: 40,
    );
Widget wdivider50() => const SizedBox(
      width: 50,
    );

Widget loadingWidget() => Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: kBrandPrimaryColor,
          strokeWidth: 2.2,
        ),
      ),
    );

showSnackBarSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Color(0xff17c3b2),
        content: Row(
          children: [
            const Icon(
              Icons.check,
              color: Colors.white,
            ),
            wdivider10(),
            Text(text),
          ],
        )),
  );
}

showSnackBarError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Colors.redAccent,
        content: Row(
          children: [
            const Icon(
              Icons.warning_amber,
              color: Colors.white,
            ),
            wdivider10(),
            Text(text),
          ],
        )),
  );
}
