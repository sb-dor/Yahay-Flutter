import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/global_usages/widgets/user_widgets/add_contact_user_widget.dart';
import 'package:yahay/core/utils/extensions/extentions.dart';
import 'package:yahay/features/add_contact_feature/view/bloc/add_contact_bloc.dart';
import 'package:yahay/features/add_contact_feature/view/bloc/add_contacts_events.dart';
import 'package:yahay/features/add_contact_feature/view/bloc/add_contacts_states.dart';
import 'package:yahay/injections/injections.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  late final DraggableScrollableController _controller;
  late final AddContactBloc _addContactBloc;
  double initialChildSize = 0.96;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
    _addContactBloc = snoopy<AddContactBloc>();
    _addContactBloc.event.add(ClearDataEvent());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      const maxHeight = 0.96;
      final screenHeight = MediaQuery.of(context).size.height * maxHeight;
      final screenHeightWithAppBar = screenHeight - kToolbarHeight;
      initialChildSize =
          ((screenHeightWithAppBar * maxHeight) / screenHeight).roundIt()?.toDouble() ?? maxHeight;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: 0.4,
      controller: _controller,
      expand: false,
      builder: (context, controller) {
        return ListView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          controller: controller,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TextField(
                      onChanged: (v) =>
                          _addContactBloc.onlySearchContactEvent.add(SearchContactEvent(v)),
                      onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                      style: GoogleFonts.aBeeZee(fontSize: 14),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          isDense: true,
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _addContactBloc.event.add(ClearDataEvent());
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            StreamBuilder<AddContactsStates>(
              stream: _addContactBloc.state,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final currentState = snapshot.requireData;
                    if (currentState is LoadingAddContactsState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (currentState is ErrorAddContactsState) {
                      return const Text("error");
                    } else if (currentState is LoadedAddContactsState) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentState.addContactStateModel.users.length,
                        itemBuilder: (context, index) {
                          final user = currentState.addContactStateModel.users[index];
                          return AddContactUserWidget(user: user);
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
