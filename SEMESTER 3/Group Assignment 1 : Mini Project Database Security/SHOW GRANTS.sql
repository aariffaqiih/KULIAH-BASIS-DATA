-- Melihat privilege per user
SHOW GRANTS FOR 'db_sekolah_admin'@'localhost';
SHOW GRANTS FOR 'kepala_sekolah'@'localhost';
SHOW GRANTS FOR 'guru'@'localhost';
SHOW GRANTS FOR 'murid'@'localhost';
SHOW GRANTS FOR 'bagian_kesiswaan'@'localhost';
SHOW GRANTS FOR 'bagian_kurikulum'@'localhost';
SHOW GRANTS FOR 'bagian_sarpras'@'localhost';

-- Melihat privilege user yang sedang login
SHOW GRANTS;

-- Melihat semua user yang ada (validasi subject)
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

-- Privilege level database
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

-- Privilege level tabel
SELECT
    User,
    Host,
    Db,
    Table_name,
    Table_priv
FROM mysql.tables_priv
WHERE Db = 'db_sekolah'
ORDER BY Table_name, User;

-- Privilege level kolom
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

-- Database-level privilege per user
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

-- Table-level privilege per user
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

-- Column-level privilege per user
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
