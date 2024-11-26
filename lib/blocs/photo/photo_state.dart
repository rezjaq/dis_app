import 'package:equatable/equatable.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoSuccess extends PhotoState {
  final String? message;
  final Map<String, dynamic>? data;

  const PhotoSuccess({this.message, this.data});

  @override
  List<Object> get props => [
    message ?? '',
    data ?? {},
  ];
}

class PhotoFailure extends PhotoState {
  final String message;

  const PhotoFailure({required this.message});

  @override
  List<Object> get props => [message];
}