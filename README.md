# Tutorial 4 - Introduction to Game Engine
- **Nama**  : Akhyar Rasyid Asy syifa
- **Kelas** : Game Development - A
- **NPM**   : 2306241682

---

## Fitur Utama yang Diimplementasikan

### 1. Perancangan Level dengan TileMap & Physics

Saya menyusun dunia permainan menggunakan `TileMapLayer` dengan aset dari Kenney Platformer Pack.

- **Physics Integration:** Setiap tile lantai saya konfigurasi dengan `Physics Layer` agar memiliki kolisi fisik yang solid.
- **Collision Painting:** Saya menggunakan `Paint Tool` pada menu TileSet untuk memastikan setiap blok tanah memiliki collision polygon yang akurat, sehingga karakter tidak menembus lantai.

---

### 2. Sistem Kamera Dinamis

Saya menambahkan node `Camera2D` sebagai child dari Player untuk kenyamanan pemain.

- **Camera Smoothing:** Saya mengaktifkan fitur `Position Smoothing` dengan kecepatan `5.0 px/s` agar pergerakan kamera terasa lebih halus dan organik saat mengikuti karakter.
- **Camera Limits:** Saya membatasi area pandang kamera menggunakan fitur `Limit` (Left, Top, Right, Bottom) agar pemain tidak melihat area kosong di luar batas map.

---

### 3. Logika Event Handling (Signals)

Saya mengimplementasikan sistem Trigger Zone menggunakan node `Area2D` dan `CollisionShape2D` untuk mengatur kondisi menang dan kalah.

- **Win Condition:** Saya menempatkan portal/roket di akhir level yang memicu perpindahan ke `WinScreen.tscn` saat mendeteksi tabrakan dengan Player.
- **Dead Zone (Fall Area):** Saya menempatkan area pemicu di bawah jurang yang berfungsi me-reload level saat pemain jatuh.
- **Signal Connection:** Seluruh logika ini dihubungkan menggunakan signal `body_entered` yang disambungkan ke fungsi pada script `area_trigger.gd`.

---

### 4. Modular Object Spawner (Hujan Ikan)

Salah satu tantangan menarik di tutorial ini adalah pembuatan rintangan dinamis.

- **RigidBody2D Obstacles:** Saya membuat objek rintangan berupa ikan jatuh yang memiliki massa dan gravitasi sendiri.
- **Spawner Logic:** Saya menggunakan script `spawner.gd` yang memanfaatkan `await get_tree().create_timer().timeout` untuk memunculkan rintangan secara periodik di posisi X yang acak (random).

---

## Level 2 — Implementasi Tambahan

### 5. Multi-Level Flow (Level 1 → Level 2)

Saya mengimplementasikan alur perpindahan antar level menggunakan `AreaTrigger` yang sudah ada di Level 1. Saya mengubah nilai `@export var sceneName` pada script `area_trigger.gd` menjadi `Level2`, sehingga saat player menyentuh area roket di akhir Level 1, game otomatis berpindah ke `Level2.tscn` via `get_tree().change_scene_to_file()`.

---

### 6. Desain Level 2

Saya merancang Level 2 menggunakan `TileMapLayer` dengan layout yang lebih menantang dari Level 1 — terdiri dari beberapa ruangan yang terhubung, platform bertingkat, dan dua jenis hazard: spike trap dan area jebakan bom. Ruang gerak sengaja saya buat lebih sempit agar tingkat kesulitan meningkat.

---

### 7. Sistem Teleport antar Ruangan (Gagal — Skill Issue)

Saya mencoba mengimplementasikan sistem teleport menggunakan node `Area2D` yang di-instance dari `teleport.tscn` dengan script `teleport.gd`. Mekanismenya adalah saat player memasuki area pintu pertama (`TeleportA`), `global_position` player di-set ke koordinat pintu kedua (`TeleportB`), dan sebaliknya.

Sayangnya, fitur ini **tidak berhasil diimplementasikan** karena murni skill issue dan keterbatasan waktu. Player terus berpindah bolak-balik akibat collision area yang langsung ter-trigger ulang sesaat setelah teleportasi terjadi. Berbagai pendekatan sudah dicoba seperti menambahkan cooldown via `await get_tree().process_frame` dan `on_cooldown` flag, namun masalah tidak terselesaikan. Akhirnya fitur ini dihapus dari scene final.

---

### 8. Win Condition Level 2

Saya mengimplementasikan kondisi menang untuk Level 2 menggunakan `AreaTrigger` yang diposisikan di depan pintu EXIT di bagian akhir level. Menggunakan script `area_trigger.gd` yang sama dengan Level 1, dengan nilai `sceneName` diset ke `WinScreen`, sehingga saat player mencapai EXIT, game menampilkan layar kemenangan `WinScreen.tscn`.
