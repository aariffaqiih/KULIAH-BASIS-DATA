SHOW INDEX FROM table_pesanan;

EXPLAIN EXTENDED
SELECT id_pesanan, id_pelanggan, waktu_pesanan, total_harga, status_pesanan
FROM table_pesanan
WHERE waktu_pesanan BETWEEN '2025-10-01' AND '2025-10-31'
  AND status_pesanan = 'selesai';

SET @waktu_mulai = TIME_TO_SEC(NOW(6));
SELECT id_pesanan, id_pelanggan, waktu_pesanan, total_harga, status_pesanan
FROM table_pesanan
WHERE waktu_pesanan BETWEEN '2025-10-01' AND '2025-10-31'
  AND status_pesanan = 'selesai';
SET @waktu_selesai = TIME_TO_SEC(NOW(6));
SELECT ROUND((@waktu_selesai - @waktu_mulai) * 1000, 3) AS total_waktu_ms;

CREATE INDEX idx_pesanan_status_waktu
ON table_pesanan (status_pesanan, waktu_pesanan);

ALTER TABLE table_pesanan
DROP INDEX idx_pesanan_status_waktu;

RESET QUERY CACHE;
FLUSH QUERY CACHE;
FLUSH TABLES;
FLUSH STATUS;

SHOW INDEX FROM table_menu;

EXPLAIN EXTENDED
SELECT id_menu, nama_menu, harga, kategori, ketersediaan
FROM table_menu
WHERE kategori = 'hidangan utama'
  AND harga BETWEEN 8000 AND 400000
  AND ketersediaan = 'tersedia';

SET @waktu_mulai = TIME_TO_SEC(NOW(6));
SELECT id_menu, nama_menu, harga, kategori, ketersediaan
FROM table_menu
WHERE kategori = 'hidangan utama'
  AND harga BETWEEN 8000 AND 400000
  AND ketersediaan = 'tersedia';
SET @waktu_selesai = TIME_TO_SEC(NOW(6));
SELECT ROUND((@waktu_selesai - @waktu_mulai) * 1000, 3) AS total_waktu_ms;

CREATE INDEX idx_menu_kat_harga_ketersediaan
ON table_menu (kategori, harga, ketersediaan);

ALTER TABLE table_menu
DROP INDEX idx_menu_kat_harga_ketersediaan;

RESET QUERY CACHE;
FLUSH QUERY CACHE;
FLUSH TABLES;
FLUSH STATUS;

SHOW INDEX FROM table_meja;

EXPLAIN EXTENDED
SELECT id_meja, nomor_meja, kapasitas, tipe_meja, status
FROM table_meja
WHERE kapasitas >= 2
  AND tipe_meja = 'VIP'
  AND status = 'available';

SET @waktu_mulai = TIME_TO_SEC(NOW(6));
SELECT id_meja, nomor_meja, kapasitas, tipe_meja, status
FROM table_meja
WHERE kapasitas >= 2
  AND tipe_meja = 'VIP'
  AND status = 'available';
SET @waktu_selesai = TIME_TO_SEC(NOW(6));
SELECT ROUND((@waktu_selesai - @waktu_mulai) * 1000, 3) AS total_waktu_ms;

CREATE INDEX idx_meja_tipe_status_kapasitas
ON table_meja (tipe_meja, status, kapasitas);

ALTER TABLE table_meja
DROP INDEX idx_meja_tipe_status_kapasitas;

RESET QUERY CACHE;
FLUSH QUERY CACHE;
FLUSH TABLES;
FLUSH STATUS;

SHOW INDEX FROM table_pesanan;

EXPLAIN EXTENDED
SELECT *
FROM table_pesanan
WHERE id_pesanan = 54;

SET @waktu_mulai = TIME_TO_SEC(NOW(6));
SELECT *
FROM table_pesanan
WHERE id_pesanan = 54;
SET @waktu_selesai = TIME_TO_SEC(NOW(6));
SELECT ROUND((@waktu_selesai - @waktu_mulai) * 1000, 3) AS total_waktu_ms;

RESET QUERY CACHE;
FLUSH QUERY CACHE;
FLUSH TABLES;
FLUSH STATUS;

SHOW INDEX FROM table_pelanggan;

EXPLAIN EXTENDED
SELECT id_pelanggan, nama_lengkap, nomor_telepon, status_loyalitas
FROM table_pelanggan
WHERE nomor_telepon LIKE '0812%';

SET @waktu_mulai = TIME_TO_SEC(NOW(6));
SELECT id_pelanggan, nama_lengkap, nomor_telepon, status_loyalitas
FROM table_pelanggan
WHERE nomor_telepon LIKE '0812%';
SET @waktu_selesai = TIME_TO_SEC(NOW(6));
SELECT ROUND((@waktu_selesai - @waktu_mulai) * 1000, 3) AS total_waktu_ms;

CREATE INDEX idx_pelanggan_tel_name
ON table_pelanggan (nomor_telepon, nama_lengkap);

ALTER TABLE table_pelanggan
DROP INDEX idx_pelanggan_tel_name;

RESET QUERY CACHE;
FLUSH QUERY CACHE;
FLUSH TABLES;
FLUSH STATUS;
