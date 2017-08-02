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
WORKDIR /home/sharptalk

RUN WINEPREFIX="/home/sharptalk/.wine" WINEARCH="win32" winetricks --unattended dotnet45

COPY lib lib
COPY .asoundrc .
COPY bin/run.sh .

ENTRYPOINT ["./run.sh"]
