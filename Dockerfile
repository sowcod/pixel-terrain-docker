FROM rikorose/gcc-cmake:gcc-9 as builder

ENV PIXEL_TERRAIN_GIT=https://github.com/kofuk/pixel-terrain.git

RUN cd /usr/src \
  && git clone ${PIXEL_TERRAIN_GIT} app \
  && cd app && ./third_party/prepare_libs.sh \
  && mkdir superbuild/build \
  && cd superbuild/build \
  && cmake .. \
  && make

FROM alpine:latest

COPY --from=builder /usr/src/app/superbuild/build/pixel-terrain/src/terrain2png /bin

RUN apk add --no-cache libc6-compat \
  && ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 \
  && apk add --no-cache libstdc++

VOLUME ["/world", "/output", "/cache"]

ENTRYPOINT ["/bin/terrain2png"]
