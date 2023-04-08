
import 'package:equatable/equatable.dart';

import '../../models/faq.dart';

class FAQState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FAQEmpty extends FAQState {}

class FAQLoading extends FAQState {}

class FAQLoaded extends FAQState {
  final List<FAQItem> list;
  FAQLoaded(this.list);
}

class FAQLoadError extends FAQState {
  final String error;
  FAQLoadError(this.error);
}