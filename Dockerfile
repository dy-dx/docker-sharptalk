FROM debian:stretch-slim

# Install wine and related packages
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        cabextract \
        wine \
        wine32 \
        xauth \
        xvfb \
    && rm -rf /var/lib/apt/lists/*

COPY bin/winetricks /usr/local/bin/

RUN useradd -ms /bin/bash sharptalk
USER sharptalk
ENV WINEPREFIX /home/sharptalk/.wine
ENV WINEARCH win32
ENV DISPLAY :0
WORKDIR /home/sharptalk

# looks like we can get away with 4.0 even though the lib asks for v4.5
# (saves a lil bit of space)
RUN winetricks --unattended dotnet40

COPY lib lib
COPY .asoundrc .
COPY bin/run.sh .

ENTRYPOINT ["./run.sh"]
