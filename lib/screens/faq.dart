import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/bloc/faq/faq_bloc.dart';
import 'package:hungry_jack/bloc/faq/faq_event.dart';
import 'package:hungry_jack/bloc/faq/faq_state.dart';
import 'package:hungry_jack/models/faq.dart';
import 'package:hungry_jack/widgets/custom_expansion_panel_list.dart';

import '../models/expansion_panel_item.dart';
import '../resources/colors.dart';
import '../resources/const.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  late List<FAQItem> faqList = [];
  late List<ExpansionPanelItem> expansionPanelList = [];

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(Const.faqs,
            style: GoogleFonts.anton(
              textStyle: const TextStyle(fontSize: 20, color: AppColors.white),
            )));
    double appBarHeight = appBar.preferredSize.height;
    return BlocProvider<FAQBloc>(
      create: (BuildContext context) => FAQBloc(),
      child: Scaffold(
        appBar: appBar,
        body: BlocBuilder<FAQBloc, FAQState>(
          builder: (BuildContext context, FAQState state) {
            if (state is FAQEmpty) {
              BlocProvider.of<FAQBloc>(context).add(FetchFAQs());
            } else if (state is FAQLoaded) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    color: AppColors.black,
                    child: const Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Text(
                          Const.faqDescription,
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  CustomExpansionPanelList(
                    data: mapFAQToExpansionPanelList(state.list),
                  ),
                ],
              ));
            } else if (state is FAQLoadError) {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                SnackBar snackBar = SnackBar(
                  content: Text(
                    state.error,
                    style:
                        const TextStyle(fontSize: 12, color: AppColors.white),
                  ),
                  backgroundColor: AppColors.red,
                  duration: const Duration(milliseconds: 2000),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<ExpansionPanelItem> mapFAQToExpansionPanelList(List<FAQItem> list) {
    List<ExpansionPanelItem> faqList = list
        .map((faq) =>
            ExpansionPanelItem(expandedValue: faq.body, headerValue: faq.title))
        .toList();
    return faqList;
  }
}
