#!/bin/bash

# 1. Jalankan core server ZiVPN menggunakan config.json di background
/app/zivpn server -c /app/config.json &

echo "Menunggu ZiVPN Server menyala..."
sleep 2

# 2. Bridge port TCP publik milik Railway ($PORT) ke port UDP lokal ZiVPN (:5667)
echo "Mengalihkan koneksi masuk TCP Port $PORT ke internal UDP Port 5667"
socat TCP-LISTEN:$PORT,fork UDP:127.0.0.1:5667
