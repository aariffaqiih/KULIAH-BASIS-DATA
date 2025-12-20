-- Menampilkan pernyataan GRANT resmi untuk setiap akun secara spesifik
-- Digunakan untuk melihat izin mentah yang diberikan oleh administrator
SHOW GRANTS FOR 'db_sekolah_admin'@'localhost';
SHOW GRANTS FOR 'kepala_sekolah'@'localhost';
SHOW GRANTS FOR 'guru'@'localhost';
SHOW GRANTS FOR 'murid'@'localhost';
SHOW GRANTS FOR 'bagian_kesiswaan'@'localhost';
SHOW GRANTS FOR 'bagian_kurikulum'@'localhost';
SHOW GRANTS FOR 'bagian_sarpras'@'localhost';

-- Menampilkan hak akses yang sedang aktif untuk sesi pengguna saat ini
SHOW GRANTS;

-- Validasi keberadaan subjek (user) dalam sistem database
-- Memastikan semua akun yang diperlukan sudah terdaftar di tabel mysql.user
SELECT user, host
FROM mysql.user
WHERE user IN (
    'db_sekolah_admin',
    'kepala_sekolah',
    'guru',
    'murid',
    'bagian_kesiswaan',
    'bagian_kurikulum',
    'bagian_sarpras'
);

-- Memeriksa hak akses pada level Database (Global di db_sekolah)
-- Menampilkan izin operasional dasar (CRUD) untuk semua user di database ini
SELECT
    user,
    host,
    Db,
    Select_priv,
    Insert_priv,
    Update_priv,
    Delete_priv
FROM mysql.db
WHERE Db = 'db_sekolah';

-- Memeriksa hak akses pada level Tabel secara mendetail
-- Berguna untuk melihat tabel mana saja yang boleh diakses oleh user tertentu
SELECT
    User,
    Host,
    Db,
    Table_name,
    Table_priv
FROM mysql.tables_priv
WHERE Db = 'db_sekolah'
ORDER BY Table_name, User;

-- Memeriksa hak akses pada level Kolom (paling spesifik/granular)
-- Memastikan field sensitif terlindungi dari user yang tidak berhak
SELECT
    User,
    Host,
    Db,
    Table_name,
    Column_name,
    Column_priv
FROM mysql.columns_priv
WHERE Db = 'db_sekolah'
ORDER BY Table_name, Column_name, User;

-- Rekapitulasi hak akses level database berdasarkan daftar user sekolah
-- Memberikan ringkasan cepat mengenai siapa yang bisa melakukan apa di level DB
SELECT
    user,
    host,
    Db,
    Select_priv,
    Insert_priv,
    Update_priv,
    Delete_priv
FROM mysql.db
WHERE user IN (
    'db_sekolah_admin',
    'kepala_sekolah',
    'guru',
    'murid',
    'bagian_kesiswaan',
    'bagian_kurikulum',
    'bagian_sarpras'
);

-- Rekapitulasi hak akses level tabel berdasarkan daftar user sekolah
-- Mengelompokkan izin tabel agar mudah dibaca per pengguna
SELECT
    User,
    Host,
    Db,
    Table_name,
    Table_priv
FROM mysql.tables_priv
WHERE User IN (
    'db_sekolah_admin',
    'kepala_sekolah',
    'guru',
    'murid',
    'bagian_kesiswaan',
    'bagian_kurikulum',
    'bagian_sarpras'
)
ORDER BY User, Table_name;

-- Audit khusus tingkat kolom untuk user 'guru'
-- Memastikan guru hanya bisa melihat kolom yang diizinkan (misal: Nama & Kelas)
SELECT
    User,
    Host,
    Db,
    Table_name,
    Column_name,
    Column_priv
FROM mysql.columns_priv
WHERE User IN ('guru')
ORDER BY Table_name, Column_name;
