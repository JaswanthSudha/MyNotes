import 'dart:async';
import 'package:my_app/constants/db.dart';
import "package:sqflite/sqflite.dart";
import "package:my_app/services/crud/crud_exceptions.dart";
import 'package:path_provider/path_provider.dart'
    show MissingPlatformDirectoryException, getApplicationDocumentsDirectory;
import 'package:path/path.dart'
    show join; //this indicated only join is used from the path package

class NotesService {
  Database? _db;
  //stream which can hold all the notes
  //which we can render them on our main ui
  List<DatabaseNote> _notes = [];
  //we will pass database notes because it should
  //controll the stream of databasenotes
  final _notesStreamController =
      StreamController<List<DatabaseNote>>.broadcast();
  Future<void> _cachedNotes() async {
    final allNotes = await getAllNotes();
    _notes = allNotes.toList();
    _notesStreamController.add(_notes);
  }

  Future<DatabaseUser> getOrCreateUser({
    required String email,
  }) async {
    try {
      final user = await getUser(email: email);
      return user;
    } on UserNotFound {
      final createdUser = await createUser(email: email);
      return createdUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteNotes() async {
    final db = _getDatabseOrThrow();
    final numberOfDeletions = await db.delete(notesTable);
    // if (numberOfDeletions == _notes.length) {
    //   _notes.clear();
    //   _notesStreamController.add(_notes);
    // }
    _notes = [];
    _notesStreamController.add(_notes);
    return numberOfDeletions;
  }

  Future<DatabaseNote> getNote({required int id}) async {
    final db = _getDatabseOrThrow();
    final notes = await db.query(
      notesTable,
      where: 'id = ?',
      limit: 1,
      whereArgs: [id],
    );
    if (notes.isEmpty) {
      throw CouldNotFindNote();
    }
    final note = DatabaseNote.fromRow(notes.first);
    //updating the notes
    _notes.removeWhere((note) => note.id == id);
    _notes.add(note);
    _notesStreamController.add(_notes);
    return note;
  }

  Future<DatabaseNote> updateNote(
      {required DatabaseNote note, required String text}) async {
    final db = _getDatabseOrThrow();
    //make sure notes exists
    await getNote(id: note.id);
    //update db
    final updateCount = await db.update(notesTable, {
      textColumn: text,
      isSyncedWithCloudColumn: 0,
    });
    if (updateCount == 0) {
      throw CouldNotUpdateNote();
    } else {
      final updatedNote = await getNote(id: note.id);
      _notes.removeWhere((note) => note.id == updatedNote.id);
      _notes.add(updatedNote);
      _notesStreamController.add(_notes);
      return updatedNote;
    }
  }

  Future<Iterable<DatabaseNote>> getAllNotes() async {
    final db = _getDatabseOrThrow();
    final notes = await db.query(notesTable);
    return notes.map((e) => DatabaseNote.fromRow(e));
  }

  Future<DatabaseNote> createNote({
    required DatabaseUser owner,
  }) async {
    //check whether the user we passed
    //is available in the databsase or not
    final db = _getDatabseOrThrow();
    final dbUser = await getUser(email: owner.email);
    if (dbUser != owner) {
      throw CouldNotDeleteUser();
    }
    const text = '';
    final noteId = await db.insert(notesTable, {
      userIdColumn: owner.id,
      textColumn: text,
      isSyncedWithCloudColumn: 1,
    });
    final note = DatabaseNote(
      id: noteId,
      userId: owner.id,
      text: text,
      isSyncedWithCloud: true,
    );
    _notes.add(note);
    _notesStreamController.add(_notes);
    return note;
  }

  Future<void> deleteNote({
    required int id,
  }) async {
    final db = _getDatabseOrThrow();
    final deletedCount = await db.delete(
      notesTable,
      where: "email = ?",
      whereArgs: [id],
    );
    if (deletedCount == 0) {
      throw CouldNotDeleteNote();
    } else {
      _notes.removeWhere((note) => note.id == id);
      _notesStreamController.add(_notes);
    }
  }

  Future<DatabaseUser> getUser({required String email}) async {
    final db = _getDatabseOrThrow();
    final list = await db.query(userTable, where: 'email = ?', whereArgs: [
      email.toLowerCase(),
    ]);
    if (list.isEmpty) {
      throw UserNotFound();
    }
    return DatabaseUser.fromRow(list.first);
  }

  Future<DatabaseUser> createUser({required String email}) async {
    final db = _getDatabseOrThrow();
    final result = await db.query(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (result.isNotEmpty) {
      throw UserAlreadyExists();
    }
    //it will return userId which is generated automatically
    //if user is not created it will simply return 0
    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });
    return DatabaseUser(id: userId, email: email);
  }

  Future<void> deleteUser({required String email}) async {
    final db = _getDatabseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email= ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) {
      throw CouldNotDeleteUser();
    }
  }

  Database _getDatabseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> close() async {
    //this function will open the connection to database
    //as it is not an immediate work has it is future we
    //declare this function as future which may going to take
    //some time
    final db = _db;
    if (db == null) throw DatabaseIsNotOpen();
    await db.close();
    _db = null;
  }

  Future<void> open() async {
    if (_db == null) throw DataBaseAlreadyOpenException();
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      //create userTable
      await db.execute(createUserTable);
      //create noteTable
      await db.execute(createNoteTable);
      //whenever we open database we need all notes and
      //put in the list and streamcontroller
      await _cachedNotes();
    } on MissingPlatformDirectoryException catch (_) {
      throw UnableToGetDocumentsDirectory();
    }
  }
}

class DatabaseUser {
  final int id;
  final String email;
  DatabaseUser({
    required this.id,
    required this.email,
  });
  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() {
    return 'Person, ID=$id, email=$email';
  }

  @override
  bool operator ==(covariant DatabaseUser other) {
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class DatabaseNote {
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;
  DatabaseNote({
    required this.id,
    required this.userId,
    required this.text,
    required this.isSyncedWithCloud,
  });
  DatabaseNote.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        text = map[textColumn] as String,
        isSyncedWithCloud =
            (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;
  @override
  String toString() {
    return 'Note ,Id=$id, userId=$userId, isSyncedWithCloud=$isSyncedWithCloud';
  }

  @override
  bool operator ==(covariant DatabaseNote other) {
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
