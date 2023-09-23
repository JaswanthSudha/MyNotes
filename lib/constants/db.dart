const dbName = "notes.db";
const notesTable = 'note';
const userTable = 'user1';
const idColumn = "id";
const userIdColumn = "user_id";
const textColumn = "text";
const isSyncedWithCloudColumn = "is_synced_with_cloud";
const emailColumn = "email";
const createNoteTable = '''CREATE TABLE "note" (
              "id"	INTEGER NOT NULL,
              "user_id"	INTEGER NOT NULL,
              "text"	TEXT,
              "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
              PRIMARY KEY("id" AUTOINCREMENT),
              FOREIGN KEY("user_id") REFERENCES "user1"("id")
            );
                ''';
const createUserTable = '''CREATE TABLE IF NOT EXISTS"user1" (
              "id"	INTEGER NOT NULL,
              "email"	TEXT NOT NULL UNIQUE,
              PRIMARY KEY("id" AUTOINCREMENT)
              );
              ''';
