import 'package:eStore/modules/on_boarding/on_boarding_screen.dart';
import 'package:eStore/shared/app_cubit/cubit.dart';
import 'package:eStore/shared/components/components.dart';
import 'package:eStore/shared/components/constants.dart';
import 'package:eStore/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatefulWidget {
  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please Select Your Language',
                    style: black18regular(),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'من فضلك إختار اللغه المناسبه',
                      style: black18regular(),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => languageItem(
                languageList[index],
                context: context,
                index: index,
              ),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: defaultSeparator(),
              ),
              itemCount: languageList.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: defaultButton(
              function: () {
                int selectedIndex = AppCubit.get(context).selectedLanguageIndex;
                if (selectedIndex == null)
                {
                  showToast(
                    text: 'please select a language then press done',
                    color: ToastColors.WARNING,
                  );
                } else
                  {
                  var model = languageList[selectedIndex];
                  print(model.code);

                  setAppLanguageToShared(model.code)
                      .then((value)
                  {
                    getTranslationFile(model.code).then((value)
                    {
                      AppCubit.get(context).setLanguage(
                        translationFile: value,
                        code: model.code,
                      ).then((value)
                      {
                        navigateAndFinish(
                          context,
                          OnBoardScreen(),
                        );
                      });
                    }).catchError((error) {});
                  })
                      .catchError((error) {});
                }
              },
              text: 'done',
            ),
          ),
        ],
      ),
    );
  }
}
