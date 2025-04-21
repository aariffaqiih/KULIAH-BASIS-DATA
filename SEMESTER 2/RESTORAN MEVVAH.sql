-- ================================================
-- DATABASE: resto_db
-- ================================================
CREATE DATABASE IF NOT EXISTS resto_db;
USE resto_db;

-- ===============================
-- TABEL: table_meja
-- ===============================
CREATE TABLE table_meja (
    id_meja INT AUTO_INCREMENT PRIMARY KEY,
    nomor_meja VARCHAR(10) NOT NULL,
    kapasitas INT NOT NULL,
    status ENUM('booked', 'available') NOT NULL
);

-- ===============================
-- TABEL: table_pelanggan
-- ===============================
CREATE TABLE table_pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    nomor_telepon VARCHAR(20),
    email VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_daftar DATE
);

-- ===============================
-- TABEL: table_reservasi
-- ===============================
CREATE TABLE table_reservasi (
    id_reservasi INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    id_meja INT NOT NULL,
    tanggal_reservasi DATE NOT NULL,
    waktu_reservasi TIME NOT NULL,
    status_reservasi ENUM('pending', 'confirmed', 'cancelled', 'completed') NOT NULL,
    FOREIGN KEY (id_pelanggan) REFERENCES table_pelanggan(id_pelanggan),
    FOREIGN KEY (id_meja) REFERENCES table_meja(id_meja)
);

-- ===============================
-- TABEL: table_diskon
-- ===============================
CREATE TABLE table_diskon (
    id_diskon INT AUTO_INCREMENT PRIMARY KEY,
    nama_diskon VARCHAR(100) NOT NULL,
    kriteria ENUM('loyal', 'event_khusus', 'hari_raya') NOT NULL,
    nilai_diskon DECIMAL(5, 2) NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE,
    deskripsi TEXT
);

-- ===============================
-- TABEL: table_pesanan
-- ===============================
CREATE TABLE table_pesanan (
    id_pesanan BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    tanggal_pesanan DATE NOT NULL,
    waktu_pesanan TIME NOT NULL,
    total_harga DECIMAL(10, 2) NOT NULL,
    id_pembayaran INT NOT NULL,
    status_pesanan VARCHAR(50) NOT NULL,
    tipe_pesanan ENUM('dine_in', 'takeaway') NOT NULL,
    id_diskon INT,
    FOREIGN KEY (id_pelanggan) REFERENCES table_pelanggan(id_pelanggan),
    FOREIGN KEY (id_diskon) REFERENCES table_diskon(id_diskon)
);

-- ===============================
-- TABEL: table_menu
-- ===============================
CREATE TABLE table_menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nama_menu VARCHAR(100) NOT NULL,
    kategori ENUM('makanan', 'minuman') NOT NULL,
    harga INT NOT NULL,
    ketersediaan BOOLEAN DEFAULT TRUE,
    deskripsi TEXT
);

-- ===============================
-- TABEL: table_pegawai
-- ===============================
CREATE TABLE table_pegawai (
    id_pegawai INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    nomor_telepon VARCHAR(20),
    email VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    jenis_kelamin ENUM('laki-laki', 'perempuan') NOT NULL,
    jabatan ENUM('pelayan', 'kasir', 'koki', 'chef', 'bartender', 'manager') NOT NULL,
    tanggal_bergabung DATE NOT NULL
);

-- ===============================
-- TABEL: table_detail_pesanan
-- ===============================
CREATE TABLE table_detail_pesanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan BIGINT NOT NULL,
    id_menu INT NOT NULL,
    jumlah_pesanan INT NOT NULL,
    catatan TEXT,
    id_pegawai INT,
    FOREIGN KEY (id_pesanan) REFERENCES table_pesanan(id_pesanan),
    FOREIGN KEY (id_menu) REFERENCES table_menu(id_menu),
    FOREIGN KEY (id_pegawai) REFERENCES table_pegawai(id_pegawai)
);

-- ===============================
-- TABEL: table_pembayaran
-- ===============================
CREATE TABLE table_pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    metode_pembayaran ENUM('cash', 'e-money') NOT NULL,
    platform ENUM('VISA', 'MasterCard', 'ShoppePay', 'Gopay', 'Dana', 'OVO') NULL,
    tanggal_pembayaran DATE NOT NULL,
    waktu_pembayaran TIME NOT NULL
);

-- ===============================
-- TABEL: table_supplier
-- ===============================
CREATE TABLE table_supplier (
    id_supplier INT AUTO_INCREMENT PRIMARY KEY,
    nama_supplier VARCHAR(100) NOT NULL,
    alamat_supplier VARCHAR(255),
    nomor_telepon VARCHAR(20),
    email VARCHAR(100)
);

-- ===============================
-- TABEL: table_bahan_baku
-- ===============================
CREATE TABLE table_bahan_baku (
    id_bahan INT AUTO_INCREMENT PRIMARY KEY,
    nama_bahan VARCHAR(100) NOT NULL,
    kategori_bahan VARCHAR(50),
    stok DECIMAL(10, 2) NOT NULL,
    satuan ENUM('kilogram', 'liter') NOT NULL,
    harga_per_unit INT,
    id_supplier INT,
    FOREIGN KEY (id_supplier) REFERENCES table_supplier(id_supplier)
);

-- ===============================
-- TABEL: table_resep
-- ===============================
CREATE TABLE table_resep (
    id_menu INT NOT NULL,
    id_bahan INT NOT NULL,
    jumlah_digunakan DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_menu, id_bahan),
    FOREIGN KEY (id_menu) REFERENCES table_menu(id_menu),
    FOREIGN KEY (id_bahan) REFERENCES table_bahan_baku(id_bahan)
);

-- ===============================
-- TABEL: table_laporan_keuangan
-- ===============================
CREATE TABLE table_laporan_keuangan (
    id_laporan INT AUTO_INCREMENT PRIMARY KEY,
    bulan TINYINT NOT NULL,
    tahun SMALLINT NOT NULL,
    id_manager INT,
    total_pendapatan DECIMAL(12, 2),
    total_pengeluaran DECIMAL(12, 2),
    total_diskon DECIMAL(12, 2),
    jumlah_pesanan INT,
    tanggal_dibuat DATE,
    FOREIGN KEY (id_manager) REFERENCES table_pegawai(id_pegawai)
);

-- ===============================
-- DATA: table_meja
-- ===============================
INSERT INTO table_meja (nomor_meja, kapasitas, status)
VALUES 
    ('M1', 4, 'available'),
    ('M2', 2, 'booked'),
    ('M3', 4, 'available'),
    ('M4', 6, 'available'),
    ('M5', 2, 'booked');

-- ===============================
-- DATA: table_pelanggan
-- ===============================
INSERT INTO table_pelanggan (nama_lengkap, nomor_telepon, email, alamat, tanggal_daftar)
VALUES 
    ('Andi Saputra', '081234567890', 'andi@mail.com', 'Jalan Merdeka No. 12, Jakarta', '2023-03-01'),
    ('Budi Prasetyo', '082345678901', 'budi@mail.com', 'Jalan Raya No. 15, Bandung', '2023-03-05'),
    ('Cynthia Wijaya', '083456789012', 'cynthia@mail.com', 'Jalan Suka No. 30, Surabaya', '2023-02-20'),
    ('Diana Santoso', '084567890123', 'diana@mail.com', 'Jalan Pahlawan No. 21, Medan', '2023-04-10'),
    ('Eko Setiawan', '085678901234', 'eko@mail.com', 'Jalan Sudirman No. 5, Yogyakarta', '2023-01-15');

-- ===============================
-- DATA: table_reservasi
-- ===============================
INSERT INTO table_reservasi (id_pelanggan, id_meja, tanggal_reservasi, waktu_reservasi, status_reservasi)
VALUES 
    (1, 1, '2023-04-20', '19:00:00', 'confirmed'),
    (2, 2, '2023-04-21', '18:30:00', 'pending'),
    (3, 3, '2023-04-22', '20:00:00', 'cancelled'),
    (4, 4, '2023-04-23', '19:30:00', 'confirmed'),
    (5, 5, '2023-04-24', '18:00:00', 'pending');

-- ===============================
-- DATA: table_diskon
-- ===============================
INSERT INTO table_diskon (nama_diskon, kriteria, nilai_diskon, tanggal_mulai, tanggal_selesai, deskripsi)
VALUES 
    ('Diskon 10%', 'loyal', 10.00, '2023-04-01', '2023-04-30', 'Diskon 10% untuk pelanggan setia.'),
    ('Diskon Hari Raya', 'hari_raya', 15.00, '2023-04-01', '2023-04-25', 'Diskon spesial Hari Raya.'),
    ('Diskon 20%', 'event_khusus', 20.00, '2023-04-15', '2023-04-20', 'Diskon khusus untuk event tahunan.'),
    ('Diskon 5%', 'loyal', 5.00, '2023-04-05', '2023-04-15', 'Diskon untuk pelanggan yang sering datang.'),
    ('Diskon 30%', 'event_khusus', 30.00, '2023-04-10', '2023-04-14', 'Diskon untuk acara spesial.');

-- ===============================
-- DATA: table_pesanan
-- ===============================
INSERT INTO table_pesanan (id_pelanggan, tanggal_pesanan, waktu_pesanan, total_harga, id_pembayaran, status_pesanan, tipe_pesanan, id_diskon)
VALUES 
    (1, '2023-04-20', '19:00:00', 200000, 1, 'completed', 'dine_in', 1),
    (2, '2023-04-21', '18:30:00', 150000, 2, 'pending', 'takeaway', 2),
    (3, '2023-04-22', '20:00:00', 300000, 3, 'cancelled', 'dine_in', 3),
    (4, '2023-04-23', '19:30:00', 100000, 4, 'completed', 'takeaway', 4),
    (5, '2023-04-24', '18:00:00', 250000, 5, 'pending', 'dine_in', 5);

-- ===============================
-- DATA: table_menu
-- ===============================
INSERT INTO table_menu (nama_menu, kategori, harga, ketersediaan, deskripsi)
VALUES 
    ('Nasi Goreng', 'makanan', 30000, TRUE, 'Nasi goreng spesial dengan telur dan ayam.'),
    ('Es Teh Manis', 'minuman', 15000, TRUE, 'Es teh manis segar dan menyegarkan.'),
    ('Mie Ayam', 'makanan', 25000, TRUE, 'Mie ayam dengan kuah kaldu gurih.'),
    ('Kopi Hitam', 'minuman', 20000, TRUE, 'Kopi hitam dengan rasa kuat.'),
    ('Sate Ayam', 'makanan', 35000, TRUE, 'Sate ayam dengan bumbu kacang khas.');


-- ===============================
-- DATA: table_pegawai
-- ===============================
INSERT INTO table_pegawai (nama, nomor_telepon, email, alamat, tanggal_lahir, jenis_kelamin, jabatan, tanggal_bergabung)
VALUES 
    ('Rina Supriyanti', '089876543210', 'rina@resto.com', 'Jalan Mawar No. 10, Jakarta', '1995-01-20', 'perempuan', 'pelayan', '2022-01-10'),
    ('Joko Setiawan', '089765432109', 'joko@resto.com', 'Jalan Anggrek No. 21, Surabaya', '1990-05-15', 'laki-laki', 'kasir', '2020-05-05'),
    ('Lina Wijayanti', '089654321098', 'lina@resto.com', 'Jalan Melati No. 30, Bandung', '1992-10-10', 'perempuan', 'koki', '2021-07-20'),
    ('Budi Hartono', '089543210987', 'budi@resto.com', 'Jalan Jati No. 25, Yogyakarta', '1988-12-30', 'laki-laki', 'manager', '2018-11-01'),
    ('Agus Santoso', '089432109876', 'agus@resto.com', 'Jalan Cempaka No. 18, Medan', '1993-02-14', 'laki-laki', 'bartender', '2021-08-15');

-- ===============================
-- DATA: table_detail_pesanan
-- ===============================
INSERT INTO table_detail_pesanan (id_pesanan, id_menu, jumlah_pesanan, catatan, id_pegawai)
VALUES 
    (1, 1, 2, 'Tambahkan telur mata sapi', 1),
    (2, 2, 1, 'Tanpa es', 2),
    (3, 3, 2, 'Tambah bakso', 3),
    (4, 4, 1, 'Tunggu di tempat', 4),
    (5, 5, 3, 'Tambah bumbu kacang', 5);

-- ===============================
-- DATA: table_pembayaran
-- ===============================
INSERT INTO table_pembayaran (metode_pembayaran, platform, tanggal_pembayaran, waktu_pembayaran)
VALUES 
    ('cash', 'VISA', '2023-04-20', '19:15:00'),
    ('e-money', 'Gopay', '2023-04-21', '18:45:00'),
    ('cash', 'MasterCard', '2023-04-22', '20:30:00'),
    ('e-money', 'OVO', '2023-04-23', '19:50:00'),
    ('cash', 'Dana', '2023-04-24', '18:20:00');

-- ===============================
-- DATA: table_supplier
-- ===============================
INSERT INTO table_supplier (nama_supplier, alamat_supplier, nomor_telepon, email)
VALUES 
    ('PT Makanan Sejahtera', 'Jalan Industri No. 2, Jakarta', '02112345678', 'makanan@sejahtera.com'),
    ('Toko Minuman Segar', 'Jalan Teh No. 5, Bandung', '02287654321', 'minuman@segarselalu.com'),
    ('CV Sumber Ayam', 'Jalan Ayam No. 7, Surabaya', '02312345678', 'ayam@sumber.com'),
    ('Toko Kopi Nusantara', 'Jalan Kopi No. 8, Medan', '02498765432', 'kopi@nusantara.com'),
    ('PT Sate Lezat', 'Jalan Sate No. 3, Yogyakarta', '02512345678', 'sate@lezat.com');

-- ===============================
-- DATA: table_bahan_baku
-- ===============================
INSERT INTO table_bahan_baku (nama_bahan, kategori_bahan, stok, satuan, harga_per_unit, id_supplier)
VALUES 
    ('Beras', 'makanan', 1000.00, 'kilogram', 12000, 1),
    ('Teh', 'minuman', 500.00, 'liter', 8000, 2),
    ('Ayam', 'makanan', 200.00, 'kilogram', 30000, 3),
    ('Kopi', 'minuman', 150.00, 'kilogram', 50000, 4),
    ('Daging Sapi', 'makanan', 300.00, 'kilogram', 60000, 5);

-- ===============================
-- DATA: table_resep
-- ===============================
INSERT INTO table_resep (id_menu, id_bahan, jumlah_digunakan)
VALUES 
    (1, 1, 0.5),
    (2, 2, 0.2),
    (3, 3, 0.3),
    (4, 4, 0.1),
    (5, 5, 0.4);

-- ===============================
-- DATA: table_laporan_keuangan
-- ===============================
INSERT INTO table_laporan_keuangan (bulan, tahun, id_manager, total_pendapatan, total_pengeluaran, total_diskon, jumlah_pesanan, tanggal_dibuat)
VALUES 
    (4, 2023, 4, 5000000.00, 3000000.00, 200000.00, 120, '2023-04-25'),
    (4, 2023, 4, 4500000.00, 2800000.00, 180000.00, 110, '2023-04-26'),
    (4, 2023, 4, 5200000.00, 3100000.00, 250000.00, 130, '2023-04-27'),
    (4, 2023, 4, 4800000.00, 2900000.00, 220000.00, 115, '2023-04-28'),
    (4, 2023, 4, 4700000.00, 2800000.00, 210000.00, 125, '2023-04-29');
