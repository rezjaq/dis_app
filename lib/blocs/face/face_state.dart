import 'package:equatable/equatable.dart';

abstract class FaceState extends Equatable {
  const FaceState();

  @override
  List<Object> get props => [];
}

class FaceInitial extends FaceState {}

class FaceLoading extends FaceState {}

class FaceSuccess extends FaceState {
  final String? message;
  final Map<String, dynamic>? data;

  const FaceSuccess({this.message, this.data});

  @override
  List<Object> get props => [
        message ?? '',
        data ?? {},
      ];
}

class FaceFailure extends FaceState {
  final String message;

  const FaceFailure({required this.message});

  @override
  List<Object> get props => [message];
}
