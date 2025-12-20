-- 1. ADMINISTRATOR UTAMA (Super User)
-- Memberikan akses penuh ke seluruh database sekolah termasuk hak untuk memberikan izin ke user lain.
GRANT ALL PRIVILEGES
ON db_sekolah.*
TO 'db_sekolah_admin'@'localhost'
WITH GRANT OPTION;

-- 2. KEPALA SEKOLAH (Monitoring)
-- Memberikan hak akses baca saja (Read-Only) pada seluruh aspek operasional sekolah.
GRANT SELECT ON db_sekolah.murid TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.nilai TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.absensi TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.jadwal TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.inventaris TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.kegiatan_kesiswaan TO 'kepala_sekolah'@'localhost';

-- 3. GURU (Operasional Akademik)
-- Membatasi akses murid hanya pada kolom tertentu, serta hak input/edit nilai dan absensi.
GRANT SELECT (nama, kelas)
ON db_sekolah.murid
TO 'guru'@'localhost';

-- Hak manajemen nilai (Input, Edit Nilai Angka, dan Hapus)
GRANT INSERT ON db_sekolah.nilai TO 'guru'@'localhost';
GRANT UPDATE (nilai_angka) ON db_sekolah.nilai TO 'guru'@'localhost';
GRANT DELETE ON db_sekolah.nilai TO 'guru'@'localhost';

-- Hak manajemen absensi (Input dan Edit Status Kehadiran)
GRANT INSERT ON db_sekolah.absensi TO 'guru'@'localhost';
GRANT UPDATE (status_hadir) ON db_sekolah.absensi TO 'guru'@'localhost';

-- 4. MURID (Self-Service View)
-- Murid hanya diizinkan melihat data melalui VIEW (Laporan) agar tidak bisa melihat data pribadi murid lain secara detail.
GRANT SELECT ON db_sekolah.v_nilai_murid TO 'murid'@'localhost';
GRANT SELECT ON db_sekolah.v_absensi_murid TO 'murid'@'localhost';

-- 5. BAGIAN KESISWAAN (Administrasi Siswa & Event)
-- Bertanggung jawab atas data induk murid, rekap absensi, dan pengelolaan agenda kegiatan sekolah.
GRANT INSERT, UPDATE, DELETE
ON db_sekolah.murid
TO 'bagian_kesiswaan'@'localhost';

GRANT SELECT
ON db_sekolah.absensi
TO 'bagian_kesiswaan'@'localhost';

GRANT INSERT, UPDATE, DELETE
ON db_sekolah.kegiatan_kesiswaan
TO 'bagian_kesiswaan'@'localhost';

-- 6. BAGIAN KURIKULUM (Manajemen Jadwal)
-- Mengelola jadwal pelajaran dan memantau capaian nilai secara keseluruhan.
GRANT INSERT, UPDATE, DELETE
ON db_sekolah.jadwal
TO 'bagian_kurikulum'@'localhost';

GRANT SELECT
ON db_sekolah.nilai
TO 'bagian_kurikulum'@'localhost';

-- 7. BAGIAN SARPRAS (Sarana & Prasarana)
-- Hak penuh untuk mengelola inventaris atau aset sekolah.
GRANT INSERT, UPDATE, DELETE, SELECT
ON db_sekolah.inventaris
TO 'bagian_sarpras'@'localhost';

FLUSH PRIVILEGES;
