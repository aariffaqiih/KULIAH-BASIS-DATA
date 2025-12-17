CREATE DATABASE db_sekolah
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE db_sekolah;

CREATE TABLE guru (
    guru_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    mapel VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE murid (
    murid_id INT AUTO_INCREMENT PRIMARY KEY,
    nis VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('L','P') NOT NULL,
    tanggal_lahir DATE NOT NULL,
    kelas VARCHAR(10) NOT NULL,
    alamat TEXT
) ENGINE=InnoDB;

CREATE TABLE nilai (
    nilai_id INT AUTO_INCREMENT PRIMARY KEY,
    murid_id INT NOT NULL,
    mapel VARCHAR(50) NOT NULL,
    semester ENUM('Ganjil','Genap') NOT NULL,
    nilai_angka DECIMAL(5,2) CHECK (nilai_angka BETWEEN 0 AND 100),
    CONSTRAINT fk_nilai_murid
        FOREIGN KEY (murid_id)
        REFERENCES murid(murid_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE absensi (
    absensi_id INT AUTO_INCREMENT PRIMARY KEY,
    murid_id INT NOT NULL,
    tanggal DATE NOT NULL,
    status_hadir ENUM('Hadir','Izin','Sakit','Alfa') NOT NULL,
    CONSTRAINT fk_absensi_murid
        FOREIGN KEY (murid_id)
        REFERENCES murid(murid_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE jadwal (
    jadwal_id INT AUTO_INCREMENT PRIMARY KEY,
    kelas VARCHAR(10) NOT NULL,
    hari ENUM('Senin','Selasa','Rabu','Kamis','Jumat') NOT NULL,
    jam_mulai TIME NOT NULL,
    jam_selesai TIME NOT NULL,
    mapel VARCHAR(50) NOT NULL,
    guru_id INT NOT NULL,
    CONSTRAINT fk_jadwal_guru
        FOREIGN KEY (guru_id)
        REFERENCES guru(guru_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE inventaris (
    inventaris_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_barang VARCHAR(100) NOT NULL,
    jumlah INT NOT NULL CHECK (jumlah >= 0),
    kondisi ENUM('Baik','Rusak') NOT NULL,
    lokasi VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE kegiatan_kesiswaan (
    kegiatan_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kegiatan VARCHAR(100) NOT NULL,
    tanggal DATE NOT NULL,
    deskripsi TEXT
) ENGINE=InnoDB;

CREATE VIEW v_nilai_murid AS
SELECT 
    m.nis,
    m.nama,
    n.mapel,
    n.semester,
    n.nilai_angka
FROM murid m
JOIN nilai n ON m.murid_id = n.murid_id;

CREATE VIEW v_absensi_murid AS
SELECT
    m.nis,
    m.nama,
    a.tanggal,
    a.status_hadir
FROM murid m
JOIN absensi a ON m.murid_id = a.murid_id;
