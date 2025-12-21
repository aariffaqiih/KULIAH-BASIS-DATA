-- 1. MENGISI DATA GURU
-- Menambahkan daftar tenaga pengajar beserta spesialisasi mata pelajaran mereka.
INSERT INTO guru (nama, mapel) VALUES
('Ahmad Fauzi', 'Matematika'),
('Siti Aminah', 'Bahasa Indonesia'),
('Budi Santoso', 'IPA'),
('Rina Lestari', 'IPS'),
('Dewi Kartika', 'Bahasa Inggris');

-- 2. MENGISI DATA MURID
-- Memasukkan identitas siswa, termasuk NIS unik dan informasi domisili.
INSERT INTO murid (nis, nama, jenis_kelamin, tanggal_lahir, kelas, alamat) VALUES
('2023001', 'Andi Pratama', 'L', '2008-01-12', '7A', 'Jl. Merdeka'),
('2023002', 'Bunga Sari', 'P', '2008-03-22', '7A', 'Jl. Sudirman'),
('2023003', 'Cahyo Nugroho', 'L', '2007-11-05', '7B', 'Jl. Diponegoro'),
('2023004', 'Dina Putri', 'P', '2007-09-18', '7B', 'Jl. Ahmad Yani'),
('2023005', 'Eko Saputra', 'L', '2008-06-30', '7C', 'Jl. Gatot Subroto');

-- 3. MENGISI DATA JADWAL PELAJARAN
-- Menghubungkan kelas, waktu, dan mata pelajaran dengan guru pengampu (menggunakan ID guru).
INSERT INTO jadwal (kelas, hari, jam_mulai, jam_selesai, mapel, guru_id) VALUES
('7A', 'Senin', '07:00:00', '08:30:00', 'Matematika', 1),
('7A', 'Selasa', '08:30:00', '10:00:00', 'Bahasa Indonesia', 2),
('7B', 'Rabu', '07:00:00', '08:30:00', 'IPA', 3),
('7B', 'Kamis', '08:30:00', '10:00:00', 'IPS', 4),
('7C', 'Jumat', '07:00:00', '08:30:00', 'Bahasa Inggris', 5);

-- 4. MENGISI DATA NILAI AKADEMIK
-- Mencatat nilai angka siswa berdasarkan murid_id yang sesuai dengan tabel murid.
INSERT INTO nilai (murid_id, mapel, semester, nilai_angka) VALUES
(1, 'Matematika', 'Ganjil', 85),
(2, 'Bahasa Indonesia', 'Ganjil', 88),
(3, 'IPA', 'Ganjil', 78),
(4, 'IPS', 'Ganjil', 90),
(5, 'Bahasa Inggris', 'Ganjil', 82);

-- 5. MENGISI DATA ABSENSI
-- Mencatat status kehadiran harian siswa (Hadir, Izin, Sakit, atau Alfa).
INSERT INTO absensi (murid_id, tanggal, status_hadir) VALUES
(1, '2024-01-10', 'Hadir'),
(2, '2024-01-10', 'Izin'),
(3, '2024-01-10', 'Hadir'),
(4, '2024-01-10', 'Sakit'),
(5, '2024-01-10', 'Alfa');

-- 6. MENGISI DATA INVENTARIS
-- Pendataan sarana prasarana sekolah, jumlah, kondisi fisik, dan lokasi peletakannya.
INSERT INTO inventaris (nama_barang, jumlah, kondisi, lokasi) VALUES
('Proyektor', 3, 'Baik', 'Ruang Guru'),
('Meja Siswa', 40, 'Baik', 'Kelas 7A'),
('Kursi Siswa', 40, 'Baik', 'Kelas 7A'),
('Laptop Sekolah', 5, 'Rusak', 'Lab Komputer'),
('Papan Tulis', 6, 'Baik', 'Setiap Kelas');

-- 7. MENGISI DATA KEGIATAN KESISWAAN
-- Jadwal agenda kegiatan ekstrakurikuler dan acara rutin sekolah.
INSERT INTO kegiatan_kesiswaan (nama_kegiatan, tanggal, deskripsi) VALUES
('Upacara Bendera', '2024-01-08', 'Upacara rutin hari Senin'),
('Lomba Kebersihan Kelas', '2024-01-15', 'Antar kelas 7'),
('Pentas Seni', '2024-02-01', 'Menampilkan bakat siswa'),
('Kerja Bakti', '2024-01-20', 'Membersihkan lingkungan sekolah'),
('Latihan Paskibra', '2024-01-25', 'Persiapan upacara besar');
