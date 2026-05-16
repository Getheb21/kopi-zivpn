FROM ubuntu:22.04

# Instal socat dan dependensi jaringan
RUN apt-get update && apt-get install -y socat chmod ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy binary ZiVPN dan script start ke dalam container
COPY zivpn /app/zivpn
COPY start.sh /app/start.sh

# Beri izin eksekusi
RUN chmod +x /app/zivpn /app/start.sh

# Jalankan script utama
CMD ["/app/start.sh"]
