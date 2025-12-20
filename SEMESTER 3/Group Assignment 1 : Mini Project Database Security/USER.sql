CREATE USER 'db_sekolah_admin'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Admin@123';

CREATE USER 'kepala_sekolah'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Kepsek@123';

CREATE USER 'guru'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Guru@123';

CREATE USER 'murid'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Murid@123';

CREATE USER 'bagian_kesiswaan'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Kesiswaan@123';

CREATE USER 'bagian_kurikulum'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Kurikulum@123';

CREATE USER 'bagian_sarpras'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'Sarpras@123';
