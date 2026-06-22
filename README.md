# Sistem Informasi Kinerja Pegawai

Aplikasi web untuk mengelola kinerja pegawai, mencakup penugasan, logbook harian, dan monitoring kinerja oleh pimpinan.

## Deskripsi Aplikasi

Sistem Informasi Kinerja Pegawai adalah aplikasi berbasis web yang dibangun menggunakan Node.js dan Express. Aplikasi ini mendukung dua peran pengguna yaitu **Pimpinan** dan **Pegawai** dengan fitur yang berbeda sesuai peran masing-masing.

### Fitur Pimpinan
- Dashboard statistik penugasan dan logbook
- Kelola penugasan (tambah, edit, hapus)
- Kirim catatan revisi ke pegawai
- Tandai tugas selesai
- Monitoring semua penugasan
- Review dan setujui/tolak logbook pegawai
- Export logbook ke PDF
- Export penugasan ke Excel

### Fitur Pegawai
- Dashboard statistik tugas pribadi
- Lihat dan kumpulkan tugas
- Kelola logbook harian (tambah, edit, hapus)
- Upload lampiran logbook

## Teknologi yang Digunakan

- **Backend**: Node.js, Express.js
- **Database**: MySQL (mysql2, tanpa ORM)
- **Frontend**: EJS, Basecoat UI, Custom CSS
- **Testing**: Playwright
- **Process Manager**: PM2
- **Version Control**: Git & GitHub


### Setup Environment
Buat file `.env` berdasarkan `.env.example`:
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=facultyware
SESSION_SECRET=rahasia123
PORT=3000

## setup testing
jalankan npm run dev
buat terminal baru dan jalankan 'npx playwright test'

## Akun Default

| Nama | Role | Password |
|------|------|----------|
| Shidiq Maihendra | Pimpinan | pimpinan123 |
| Duha Alul Bariq | Pegawai | pegawai123 |
| Adinda Najwa | Pegawai | pegawai123 |
| Shifa Khalishah | Pegawai | pegawai123 |

## Pembagian Tugas Anggota

| Nama | NIM | Tugas |
|------|-----|-------|
| Shidiq Maihendra | - | Autentikasi, Dashboard, Penugasan |
| Duha Alul Bariq | - | Logbook, Export PDF, REST API |
| Adinda Najwa | - | Monitoring, Export Excel |
| Shifa Khalishah | - | Testing Playwright, Deployment |

## Link Aplikasi

http://103.55.37.148