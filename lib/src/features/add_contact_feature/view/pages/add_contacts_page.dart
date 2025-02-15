import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/ui_kit/user_widgets/add_contact_user_widget.dart';
import 'package:yahay/src/core/utils/extensions/extensions.dart';
import 'package:yahay/src/features/add_contact_feature/bloc/add_contact_bloc.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';

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
    _addContactBloc = DependenciesScope.of(context, listen: false).addContactBloc;
    _addContactBloc.add(const AddContactsEvents.clearDataEvent());
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
                      onChanged: (v) => _addContactBloc.add(AddContactsEvents.searchContact(v)),
                      onSubmitted: (v) => _addContactBloc.add(AddContactsEvents.searchContact(v)),
                      onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                      style: GoogleFonts.aBeeZee(fontSize: 14),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          isDense: true,
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _addContactBloc.add(const AddContactsEvents.clearDataEvent());
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<AddContactBloc, AddContactsStates>(
              bloc: _addContactBloc,
              builder: (context, states) {
                switch (states) {
                  case InitialAddConstactsState():
                  case AddContacts$InProgressState():
                    return const Center(child: CircularProgressIndicator());
                  case AddContacts$ErrorState():
                    return const Text("error");
                  case AddContacts$SuccessfulState():
                    final currentStateModel = states.addContactStateModel;
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentStateModel.users.length,
                      itemBuilder: (context, index) {
                        final user = currentStateModel.users[index];
                        return AddContactUserWidget(
                          user: user,
                          addUser: () =>
                              _addContactBloc.add(AddContactsEvents.addContactEvent(user)),
                        );
                      },
                    );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
