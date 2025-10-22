import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saqar/constant.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/helper/widgets/custome_text_form_field.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/quran_custom_scrol_view.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});
  static final String routeName = "/MainHomePage";

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {}); // 🔁 يحدث الواجهة عند الكتابة
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.resourceImagesBackgroundQuran),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 32,
              left: 32,
              top: 16,
              child: Image.asset(
                width: MediaQuery.sizeOf(context).width,
                Assets.resourceImagesMosque,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  Constant.appName,
                  style: AppTextSyles.textStyle80se(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomeTextFormField(
                    controller: controller,
                    hintText: "sura name",
                    prefixIcon: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(Assets.resourceImagesQuranIcon),
                      ),
                    ),
                  ),
                ),
                controller.text.isEmpty
                    ? const QuranCustomScrolView()
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
