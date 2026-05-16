#!/bin/bash

# 1. Jalankan binary ZiVPN di latar belakang (misal ZiVPN pakai port UDP 5678)
./zivpn -port 5678 & 

# 2. Ambil port TCP publik yang disediakan oleh Railway
# Lalu alihkan semua traffic TCP masuk dari Railway ke port UDP ZiVPN di dalam internal server
echo "Mengalihkan TCP port $PORT ke UDP port 5678..."
socat TCP-LISTEN:$PORT,fork UDP:127.0.0.1:5678
