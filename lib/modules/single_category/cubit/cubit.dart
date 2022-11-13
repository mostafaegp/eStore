import 'package:eStore/models/single_category/single_category_model.dart';
import 'package:eStore/modules/single_category/cubit/states.dart';
import 'package:eStore/shared/app_cubit/cubit.dart';
import 'package:eStore/shared/components/constants.dart';
import 'package:eStore/shared/network/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SingleCategoryCubit extends Cubit<SingleCategoryStates>
{
  final Repository repository;

  SingleCategoryCubit(this.repository) : super(SingleCategoryInitialState());

  static SingleCategoryCubit get(context) => BlocProvider.of(context);

  SingleCategoryModel singleCategoryModel;

  getCategories(int id, context)
  {
    emit(SingleCategoryLoadingState());

    repository
        .getSingleCategory(token: userToken, id: id)
        .then((value)
    {
      singleCategoryModel = SingleCategoryModel.fromJson(value.data);

      singleCategoryModel.data.data.forEach((element)
      {
        if(!AppCubit.get(context).favourites.containsKey(element.id))
        {
          AppCubit.get(context).favourites.addAll({
            element.id: element.inFavorites
          });
        }

        if(!AppCubit.get(context).cart.containsKey(element.id))
        {
          AppCubit.get(context).cart.addAll({
            element.id: element.inCart
          });

          if(element.inCart)
          {
            AppCubit.get(context).cartProductsNumber++;
          }
        }

      });

      emit(SingleCategorySuccessState());

      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      emit(SingleCategoryErrorState(error.toString()));
    });
  }
}