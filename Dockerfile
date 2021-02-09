FROM alpine

LABEL maintainer="Patrice Ferlet <metal3d@gmail.com>"

ARG VERSION=6.8.1
    
RUN set -xe; \
    apk update; \
    apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers; \
    git clone https://github.com/xmrig/xmrig.git; \
    mkdir xmrig/build; \
    cd xmrig/scripts && ./build_deps.sh && cd ../build; \
    cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON; \
    make -j$(nproc); \
    cp xmrig /usr/local/bin/xmrig;\
    rm -rf xmrig* *.tar.gz; \
    apk del build-base; \
    apk del cmake; \
    apk del automake; \
    apk del libtool; \
    apk del autoconf; \ 
    apk del linux-headers;

ENV POOL_USER="44vjAVKLTFc7jxTv5ij1ifCv2YCFe3bpTgcRyR6uKg84iyFhrCesstmWNUppRCrxCsMorTP8QKxMrD3QfgQ41zsqMgPaXY5" \
    POOL_PASS="" \
    POOL_URL="xmr.metal3d.org:8080" \
    DONATE_LEVEL=5 \
    PRIORITY=0 \
    THREADS=0

ADD entrypoint.sh /entrypoint.sh
WORKDIR /tmp
EXPOSE 3000
CMD ["/entrypoint.sh"]
