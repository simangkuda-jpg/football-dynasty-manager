# Football Dynasty: Manager — MVP Phase 1

## Cara pakai (tanpa PC, full dari HP)

1. Push folder ini ke repo GitHub baru (lewat app GitHub, Working Copy, atau upload manual di web GitHub dari HP).
2. Buka tab **Actions** di repo → workflow **Build APK** akan otomatis jalan tiap push ke branch `main` (atau trigger manual via "Run workflow").
3. Setelah selesai (~5-10 menit), buka run yang sukses → download artifact **football-dynasty-manager-apk**.
4. Extract zip artifact → dapat `app-release.apk` → install di HP Android.

## Isi MVP Phase 1

- Main Menu, New Career, Manager Creation, Club Selection
- Home Dashboard, Squad, Player Detail, Tactics
- Match Simulation (match engine berbasis atribut + taktik), League Table
- Save/Load otomatis (1 slot, JSON file di local storage)
- Data: 10 klub fiktif, 200 pemain procedural generation

## Belum termasuk (Phase 2 dst)

Transfer market, scouting, contract negotiation, training system, staff, board, finance mendalam, media, dynamic events, youth academy.
