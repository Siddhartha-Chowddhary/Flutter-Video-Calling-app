import 'package:cloud_firestore/cloud_firestore.dart';


class DataBaseServices {

  final String UID;

  DataBaseServices({this.UID});

  final CollectionReference MeetingIDCollection =  Firestore.instance.collection('MeetingIDs');

  Future updateUserData(String MeetingID) async {

    return await MeetingIDCollection.document(UID).setData({

      'MeetingID':MeetingID

    });

  }
}
