import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocalStorageCubit extends HydratedCubit<Map<String, dynamic>> {
  LocalStorageCubit() : super({});

  Future<void> saveData<T>(String key, T value) async {
    final newState = Map<String, dynamic>.from(state);
    newState[key] = value;
    emit(newState);
  }

  T? readData<T>(String key) {
    return state[key] as T?;
  }

  Future<void> removeData(String key) async {
    final newState = Map<String, dynamic>.from(state);
    newState.remove(key);
    emit(newState);
  }

  Future<void> clearAll() async {
    emit({});
  }

  @override
  Map<String, dynamic>? fromJson(Map<String, dynamic> json) {
    return json;
  }

  @override
  Map<String, dynamic>? toJson(Map<String, dynamic> state) {
    return state;
  }
}