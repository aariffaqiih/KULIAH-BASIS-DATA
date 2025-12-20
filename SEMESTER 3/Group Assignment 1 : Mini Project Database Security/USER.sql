-- Membuat user Admin Utama dengan akses lokal dan enkripsi password modern (SHA2)
CREATE USER 'db_sekolah_admin'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Admin@123';

-- Membuat user untuk Kepala Sekolah sebagai pemantau kebijakan
CREATE USER 'kepala_sekolah'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Kepsek@123';

-- Membuat user untuk Guru sebagai pengelola data akademik harian
CREATE USER 'guru'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Guru@123';

-- Membuat user untuk Murid dengan akses terbatas pada data pribadi/nilai
CREATE USER 'murid'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Murid@123';

-- Membuat user untuk Bagian Kesiswaan (Manajemen perilaku dan event)
CREATE USER 'bagian_kesiswaan'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Kesiswaan@123';

-- Membuat user untuk Bagian Kurikulum (Manajemen jadwal dan standar nilai)
CREATE USER 'bagian_kurikulum'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Kurikulum@123';

-- Membuat user untuk Bagian Sarpras (Manajemen inventaris sekolah)
CREATE USER 'bagian_sarpras'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Sarpras@123';

-- Menampilkan nama user, host asal, dan plugin autentikasi dari tabel sistem MySQL
SELECT user, host, plugin
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
