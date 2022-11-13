import 'package:eStore/shared/app_cubit/cubit.dart';
import 'package:eStore/shared/components/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: ()
      {
        setAppLanguageToShared('en')
            .then((value)
        {
          getTranslationFile('en').then((value)
          {
            AppCubit.get(context).setLanguage(
              translationFile: value,
              code: 'en',
            ).then((value)
            {

            });
          }).catchError((error) {});
        })
            .catchError((error) {});
      },
      child: Text(
        'change',
      ),
    );
  }
}
