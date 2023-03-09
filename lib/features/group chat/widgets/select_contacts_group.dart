import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/common/widgets/error.dart';
import 'package:whats_up/common/widgets/loader.dart';
import 'package:whats_up/features/contacts/controller/contact_controller.dart';

final selectedGroupContacts = StateProvider<List<Contact>>((ref) => []);

class SelectContactsGroup extends ConsumerStatefulWidget {
  const SelectContactsGroup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactsGroupState();
}

class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
  List<int> selectedContactsIndex = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.removeAt(index);
    } else {
      selectedContactsIndex.add(index);
    }
    setState(() {});
    //updating the state required us to have the preioud one and an extra contact
    //if we add just [contact], it'll think that we want all the previous stat to be overriden by that
    //and we don't want that, we want all the previous state to come in as well, so we add ...state
    ref.read(selectedGroupContacts.state).update((state) => [   ...state ,contact]);
  }

  @override
  Widget build(BuildContext context) {
    return ref.read(getContactsProvider).when(
          data: (contactList) => Expanded(
            child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(index, contact),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      leading: selectedContactsIndex.contains(index)
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.done),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          error: (err, trace) => ErrorScreen(
            error: err.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
