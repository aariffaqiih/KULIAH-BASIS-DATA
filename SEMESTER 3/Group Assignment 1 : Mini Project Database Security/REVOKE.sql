-- Dampak: Kepala sekolah tidak bisa melihat detail nilai siswa, hanya data non-akademik.
REVOKE SELECT
ON db_sekolah.nilai
FROM 'kepala_sekolah'@'localhost';

-- Dampak: Guru tidak bisa menghapus nilai, hanya input & koreksi nilai.
REVOKE DELETE
ON db_sekolah.nilai
FROM 'guru'@'localhost';

-- Dampak: Murid hanya bisa melihat nilai, tidak absensi.
REVOKE SELECT
ON db_sekolah.v_absensi_murid
FROM 'murid'@'localhost';

-- Dampak: Data murid tidak bisa dihapus, hanya diperbarui.
REVOKE DELETE
ON db_sekolah.murid
FROM 'bagian_kesiswaan'@'localhost';

-- Dampak: Kurikulum tidak bisa mengubah jadwal, hanya insert & delete.
REVOKE UPDATE
ON db_sekolah.jadwal
FROM 'bagian_kurikulum'@'localhost';

-- Dampak: Aset tidak bisa dihapus, hanya diperbarui statusnya.
REVOKE DELETE
ON db_sekolah.inventaris
FROM 'bagian_sarpras'@'localhost';
