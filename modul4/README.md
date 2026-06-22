# Modul 4 - Monitoring & Dashboard

Sistem Kinerja Pegawai (B04)
PJ: Adinda Najwa Otvatiani - 2411523003

## Setup
1. `npm install`
2. Copy `.env.example` jadi `.env`, sesuaikan kredensial DB
3. Import database: `facultyware.sql` ke MySQL (database name: `facultyware`)
4. (Opsional) jalankan `node seeder.js` untuk seed data awal
5. `npm run dev` (pakai nodemon) atau `npm start`
6. Akses di `http://localhost:3000`

## Fitur
- Pimpinan dapat melihat dashboard ringkasan sistem
- Pegawai dapat melihat dashboard aktivitas miliknya
- Pimpinan dapat memonitor seluruh status penugasan pegawai
- Pimpinan dapat memfilter daftar monitoring penugasan berdasarkan statusnya
- Pimpinan dapat mengekspor laporan rekapitulasi kinerja pegawai ke dalam format PDF
- RestAPI untuk mengakses data monitoring dan statistik penugasan
