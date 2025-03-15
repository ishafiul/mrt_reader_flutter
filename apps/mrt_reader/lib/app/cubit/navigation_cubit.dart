import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); // Default to first tab (Scan Card)

  void setTab(int index) => emit(index);
} 