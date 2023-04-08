import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_jack/bloc/faq/faq_event.dart';
import 'package:hungry_jack/bloc/faq/faq_state.dart';
import 'package:hungry_jack/models/faq.dart';

import '../../services/firebase_service.dart';

class FAQBloc extends Bloc<FAQEvent, FAQState> {
  final FirebaseService _firebaseService = FirebaseService();

  FAQBloc() : super(FAQEmpty()) {
    on<FetchFAQs>((event, emit) async {
      try {
        emit(FAQLoading());
        QuerySnapshot querySnapshot = await _firebaseService.getFAQList();
        List<FAQItem> faqList =
            querySnapshot.docs.map((faq) => FAQItem.fromDocument(faq)).toList();
        emit(FAQLoaded(faqList));
      } catch (e) {
        emit(FAQLoadError(e.toString()));
      }
    });
  }
}
