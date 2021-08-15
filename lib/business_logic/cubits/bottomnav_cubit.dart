import 'package:bloc/bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void updateIndex(int index) {
    emit(index);
  }

  void getHome() => emit(0);
  void getSetting() => emit(1);
}
