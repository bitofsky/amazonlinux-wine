FROM amazonlinux:2022.0.20221019.4

WORKDIR /wine-installer

RUN dnf -y update

# Install Software Building dependencies
RUN dnf groupinstall 'Development Tools' -y
RUN dnf -y install libxslt-devel libpng-devel libX11-devel zlib-devel libtiff-devel freetype-devel libxcb-devel  libxml2-devel libgcrypt-devel dbus-devel libjpeg-turbo-devel  fontconfig-devel gnutls-devel libXcursor-devel libXi-devel libXrandr-devel libXfixes-devel libXinerama-devel libXcomposite-devel mesa-libOSMesa-devel libpcap-devel libusb-devel libgudev gsm-devel libudev-devel 

# Install Wine 7
RUN dnf -y install wget
RUN curl -O https://dl.winehq.org/wine/source/7.0/wine-7.0.tar.xz
RUN tar xvf wine-7.0.tar.xz
RUN cd wine-7.0 && ./configure --enable-win64 && make && make install
RUN ln -s /usr/local/bin/wine64 /usr/local/bin/wine

# Confirm Wine 7 installation
RUN wine --help

RUN wine cmd /c echo %PATH%
