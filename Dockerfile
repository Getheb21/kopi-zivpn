FROM ubuntu:22.04

# Instal dependensi dasar, openssl untuk sertifikat, dan socat untuk tunneling
RUN apt-get update && apt-get install -y \
    wget \
    socat \
    openssl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Unduh binary ZiVPN resmi (versi AMD64 sesuai script zi.sh)
RUN wget https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-amd64 -O /app/zivpn && \
    chmod +x /app/zivpn

# Generate sertifikat SSL (Self-Signed) yang dibutuhkan oleh ZiVPN
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=California/L=Los Angeles/O=Example Corp/OU=IT Department/CN=zivpn" \
    -keyout /app/zivpn.key -out /app/zivpn.crt

# Salin config.json lokal ke dalam container
COPY config.json /app/config.json
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
