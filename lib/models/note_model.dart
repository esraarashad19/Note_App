class NoteModel {
  String? noteId;
  late String name;
  var date;
  String? note;
  String? attachType;
  String? attachmentFile;
  NoteModel({
    this.noteId,
    required this.name,
    required this.date,
    required this.note,
    this.attachmentFile,
    required this.attachType,
  });
  NoteModel.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    note = json['note'];
    noteId = json['noteId'];
    attachmentFile = json['attachmentFile'];
    attachType = json['attachType'];
  }

  Map<String, dynamic> toMap() => {
        'noteId': noteId,
        'name': name,
        'date': date,
        'note': note,
        'attachmentFile': attachmentFile,
        'attachType': attachType,
      };
}
