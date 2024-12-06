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

class FindmeSuccess extends PhotoState {
  final String? message;
  final Map<String, dynamic>? all;
  final Map<String, dynamic>? collections;
  final List<dynamic>? favorites;

  const FindmeSuccess(
      {this.message, this.all, this.collections, this.favorites});

  @override
  List<Object> get props =>
      [message ?? '', all ?? {}, collections ?? {}, favorites ?? []];
}

class FindmeFailure extends PhotoState {
  final String messageAll;
  final String messageCollections;

  const FindmeFailure(
      {required this.messageAll, required this.messageCollections});

  @override
  List<Object> get props => [messageAll, messageCollections];
}

class PhotoByAccountSuccess extends PhotoState {
  final String? message;
  final Map<String, dynamic> sell;
  final Map<String, dynamic> post;

  const PhotoByAccountSuccess(
      {this.message, required this.sell, required this.post});

  @override
  List<Object> get props => [
        message ?? '',
        sell,
        post,
      ];
}

class PhotoByAccountFailure extends PhotoState {
  final String messageSell;
  final String messagePost;

  const PhotoByAccountFailure(
      {required this.messageSell, required this.messagePost});

  @override
  List<Object> get props => [messageSell, messagePost];
}
