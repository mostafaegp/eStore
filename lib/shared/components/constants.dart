import 'package:eStore/shared/app_cubit/cubit.dart';
import 'package:eStore/shared/di/di.dart';
import 'package:eStore/shared/language/app_language_model.dart';
import 'package:eStore/shared/network/local/cache_helper.dart';
import 'package:flutter/services.dart';


AppLanguageModel appLang(context) => AppCubit.get(context).languageModel;

String appLanguage = '';

String userToken = '';

Future<String> getAppLanguage() async
{
  return await di<CacheHelper>().get('appLang');
}

Future<String> getUserToken() async
{
  return await di<CacheHelper>().get('userToken');
}

Future<bool> setAppLanguageToShared(String code) async
{
  appLanguage = code;
  return await di<CacheHelper>().put('appLang', code);
}

Future<String> getTranslationFile(String appLanguage) async
{
  return await rootBundle
      .loadString('assets/translation/${appLanguage ?? 'en'}.json');
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}