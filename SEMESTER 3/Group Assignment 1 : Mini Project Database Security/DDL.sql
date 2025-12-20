CREATE DATABASE db_sekolah
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE db_sekolah;

-- Tabel Guru: Menyimpan profil dasar tenaga pengajar
CREATE TABLE guru (
    guru_id INT AUTO_INCREMENT PRIMARY KEY, -- ID unik otomatis untuk setiap guru
    nama VARCHAR(100) NOT NULL,             -- Nama guru (wajib diisi)
    mapel VARCHAR(50) NOT NULL              -- Mata pelajaran yang diampu
) ENGINE=InnoDB;

-- Tabel Murid: Menyimpan profil dasar siswa
CREATE TABLE murid (
    murid_id INT AUTO_INCREMENT PRIMARY KEY, -- ID unik sistem
    nis VARCHAR(20) NOT NULL UNIQUE,         -- Nomor Induk Siswa (harus unik/tidak boleh kembar)
    nama VARCHAR(100) NOT NULL,              -- Nama lengkap murid
    jenis_kelamin ENUM('L','P') NOT NULL,    -- Pilihan Laki-laki atau Perempuan
    tanggal_lahir DATE NOT NULL,             -- Format: YYYY-MM-DD
    kelas VARCHAR(10) NOT NULL,              -- Identifikasi kelas (misal: X-IPA1)
    alamat TEXT                              -- Alamat lengkap dengan tipe data teks panjang
) ENGINE=InnoDB;

-- Tabel Nilai: Menyimpan perolehan nilai akademik siswa
CREATE TABLE nilai (
    nilai_id INT AUTO_INCREMENT PRIMARY KEY,
    murid_id INT NOT NULL,                   -- Relasi ke tabel murid
    mapel VARCHAR(50) NOT NULL,
    semester ENUM('Ganjil','Genap') NOT NULL,
    nilai_angka DECIMAL(5,2) CHECK (nilai_angka BETWEEN 0 AND 100), -- Validasi nilai 0-100
    CONSTRAINT fk_nilai_murid
        FOREIGN KEY (murid_id)
        REFERENCES murid(murid_id)
        ON DELETE CASCADE                    -- Jika data murid dihapus, nilai ikut terhapus
) ENGINE=InnoDB;

-- Tabel Absensi: Mencatat kehadiran harian siswa
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

-- Tabel Jadwal: Mengatur slot waktu pelajaran dan guru pengampu
CREATE TABLE jadwal (
    jadwal_id INT AUTO_INCREMENT PRIMARY KEY,
    kelas VARCHAR(10) NOT NULL,
    hari ENUM('Senin','Selasa','Rabu','Kamis','Jumat') NOT NULL,
    jam_mulai TIME NOT NULL,
    jam_selesai TIME NOT NULL,
    mapel VARCHAR(50) NOT NULL,
    guru_id INT NOT NULL,                    -- Relasi ke tabel guru
    CONSTRAINT fk_jadwal_guru
        FOREIGN KEY (guru_id)
        REFERENCES guru(guru_id)
        ON DELETE RESTRICT                   -- Guru tidak bisa dihapus jika masih ada jadwal
) ENGINE=InnoDB;

-- Tabel Inventaris: Mencatat sarana dan prasarana sekolah
CREATE TABLE inventaris (
    inventaris_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_barang VARCHAR(100) NOT NULL,
    jumlah INT NOT NULL CHECK (jumlah >= 0), -- Jumlah barang tidak boleh negatif
    kondisi ENUM('Baik','Rusak') NOT NULL,
    lokasi VARCHAR(100) NOT NULL             -- Tempat penyimpanan barang
) ENGINE=InnoDB;

-- Tabel Kegiatan Kesiswaan: Mencatat agenda atau event sekolah
CREATE TABLE kegiatan_kesiswaan (
    kegiatan_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kegiatan VARCHAR(100) NOT NULL,
    tanggal DATE NOT NULL,
    deskripsi TEXT
) ENGINE=InnoDB;

-- View v_nilai_murid: Menampilkan laporan nilai lengkap dengan Nama dan NIS
CREATE VIEW v_nilai_murid AS
SELECT 
    m.nis,
    m.nama,
    n.mapel,
    n.semester,
    n.nilai_angka
FROM murid m
JOIN nilai n ON m.murid_id = n.murid_id;

-- View v_absensi_murid: Menampilkan rekap kehadiran harian siswa
CREATE VIEW v_absensi_murid AS
SELECT
    m.nis,
    m.nama,
    a.tanggal,
    a.status_hadir
FROM murid m
JOIN absensi a ON m.murid_id = a.murid_id;
