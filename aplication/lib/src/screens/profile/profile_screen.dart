import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/common/file_helper.dart';
import 'package:mikinder/src/common/text_helper.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';
import 'package:mikinder/src/screens/profile/profile_controller.dart';
import 'package:mikinder/src/screens/profile/widget/address_input.dart';
import 'package:mikinder/src/screens/profile/widget/cellphone_input.dart';
import 'package:mikinder/src/screens/profile/widget/change_password_button.dart';
import 'package:mikinder/src/screens/profile/widget/email_input.dart';
import 'package:mikinder/src/screens/profile/widget/maternal_input.dart';
import 'package:mikinder/src/screens/profile/widget/name_input.dart';
import 'package:mikinder/src/screens/profile/widget/paternal_input.dart';
import 'package:mikinder/src/screens/profile/widget/phone_input.dart';
import 'package:mikinder/src/widgets/avatar_image.dart';
import 'package:mikinder/src/widgets/stateful_wrapper.dart';
import 'package:mikinder/src/widgets/upload_file/upload_file.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final pref = PreferencesProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>.value(
      value: ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, profileController, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: kFourthColor,
          ),
          backgroundColor: kThridColor,
          body: StatefulWrapper(
            onMounted: profileController.getProfile,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding, right: kDefaultPadding),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: kDefaultPadding * 1.3),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => UploadFile((image) async {
                                  profileController.inAsyncCall = true;
                                  String imageUpload = await uploadFile(
                                      image,
                                      'user/${pref.user.id}',
                                      '${pref.user.id}-${DateTime.now().toIso8601String()}',
                                      kTargetWidthUser);
                                  profileController.changeImage(imageUpload);
                                }),
                              );
                            },
                            child: CircularPercentIndicator(
                              radius: 50.0,
                              lineWidth: 3.0,
                              percent: 1.0,
                              center: AvatarImage(
                                width: 80,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                image: profileController.image,
                                child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kPrimaryColor,
                                    child:
                                        Icon(Icons.edit, color: Colors.white),
                                  ),
                                ),
                              ),
                              progressColor: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding * 1.3),
                          _contentIsNotDeliveryMan(profileController),
                          const SizedBox(height: kDefaultPadding * 5),
                        ],
                      ),
                    ),
                  )),
                ),
                // ProfileButton(profileController, formKey: formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentIsNotDeliveryMan(ProfileController profileController) {
    return Column(
      children: [
        NameInput(profileController),
        const SizedBox(height: kDefaultPadding * 1.3),
        PaternalInput(profileController),
        const SizedBox(height: kDefaultPadding * 1.3),
        MaternalInput(profileController),
        const SizedBox(height: kDefaultPadding * 1.3),
        PhoneInput(profileController),
        const SizedBox(height: kDefaultPadding * 1.3),
        CellphoneInput(profileController),
        const SizedBox(height: kDefaultPadding * 1.3),
        EmailInput(profileController),
        const SizedBox(height: kDefaultPadding * 2.6),
        ChangePasswordButton(profileController),
      ],
    );
  }
}
