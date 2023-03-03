import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_contacts_messages/core/helpers/view_functions.dart';
import 'package:telephony/telephony.dart';

final contactsProvider =
    ChangeNotifierProvider<ContactsProvider>((ref) => ContactsProvider());

class ContactsProvider extends ChangeNotifier {
  List<Contact> _contacts;
  List<SmsMessage> _messages;

  ContactsProvider()
      : _contacts = [],
        _messages = [];

  getContactList(
    BuildContext context,
  ) async {
    if (await FlutterContacts.requestPermission()) {
      _contacts = await FlutterContacts.getContacts(
        withProperties: true,
      ).then(
        (value) {
          value.isNotEmpty
              ? {
                  ViewFunctions.showCustomSnackBar(
                      context: context, text: 'تم تحميل جهات الاتصال')
                }
              : {
                  ViewFunctions.showCustomSnackBar(
                      context: context, text: 'لم يتم تحميل جهات الاتصال')
                };
          return value;
        },
      ).catchError(
        (onError) {
          ViewFunctions.showCustomSnackBar(
              context: context, text: 'فشل تحميل جهات الاتصال');
          return <Contact>[];
        },
      );
      notifyListeners();
    } else if (context.mounted) {
      ViewFunctions.showCustomSnackBar(
        context: context,
        text: 'لم يتم الحصول على الاذن للوصول لجهات الاتصال',
      );
    }
  }

  getMessagesList(
    BuildContext context,
  ) async {
    final Telephony telephony = Telephony.instance;
    if (await telephony.requestPhoneAndSmsPermissions ?? false) {
      _messages = await telephony.getInboxSms(columns: [SmsColumn.ADDRESS, SmsColumn.BODY],).then(
        (value) {
          if (value.isNotEmpty) {
            ViewFunctions.showCustomSnackBar(
              context: context,
              text: 'تم تحميل الرسائل',
            );
          } else {
            ViewFunctions.showCustomSnackBar(
              context: context,
              text: 'لم يتم تحميل الرسائل',
            );
          }
          return value;
        },
      ).catchError(
        (onError) {
          log(">>>>>>>>>>>>  $onError");
          ViewFunctions.showCustomSnackBar(
              context: context, text: 'فشل تحميل الرسائل');
          return <SmsMessage>[];
        },
      );
      notifyListeners();
    } else if (context.mounted) {
      ViewFunctions.showCustomSnackBar(
        context: context,
        text: 'لم يتم الحصول على الاذن للوصول الى الرسائل',
      );
    }
  }

  List<Contact> get contactList => _contacts;

  List<SmsMessage> get messagesList => _messages;
}
