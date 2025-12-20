GRANT ALL PRIVILEGES
ON db_sekolah.*
TO 'db_sekolah_admin'@'localhost'
WITH GRANT OPTION;

GRANT SELECT ON db_sekolah.murid TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.nilai TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.absensi TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.jadwal TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.inventaris TO 'kepala_sekolah'@'localhost';
GRANT SELECT ON db_sekolah.kegiatan_kesiswaan TO 'kepala_sekolah'@'localhost';

GRANT SELECT (nama, kelas)
ON db_sekolah.murid
TO 'guru'@'localhost';
GRANT INSERT ON db_sekolah.nilai TO 'guru'@'localhost';
GRANT UPDATE (nilai_angka) ON db_sekolah.nilai TO 'guru'@'localhost';
GRANT DELETE ON db_sekolah.nilai TO 'guru'@'localhost';
GRANT INSERT ON db_sekolah.absensi TO 'guru'@'localhost';
GRANT UPDATE (status_hadir) ON db_sekolah.absensi TO 'guru'@'localhost';

GRANT SELECT ON db_sekolah.v_nilai_murid TO 'murid'@'localhost';
GRANT SELECT ON db_sekolah.v_absensi_murid TO 'murid'@'localhost';

GRANT INSERT, UPDATE, DELETE
ON db_sekolah.murid
TO 'bagian_kesiswaan'@'localhost';
GRANT SELECT
ON db_sekolah.absensi
TO 'bagian_kesiswaan'@'localhost';
GRANT INSERT, UPDATE, DELETE
ON db_sekolah.kegiatan_kesiswaan
TO 'bagian_kesiswaan'@'localhost';

GRANT INSERT, UPDATE, DELETE
ON db_sekolah.jadwal
TO 'bagian_kurikulum'@'localhost';

GRANT SELECT
ON db_sekolah.nilai
TO 'bagian_kurikulum'@'localhost';

GRANT INSERT, UPDATE, DELETE, SELECT
ON db_sekolah.inventaris
TO 'bagian_sarpras'@'localhost';

FLUSH PRIVILEGES;
