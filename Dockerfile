FROM public.ecr.aws/sam/build-nodejs16.x

WORKDIR /build

ARG VIPS_VERSION
ENV VIPS_VERSION=$VIPS_VERSION
ENV PATH=/opt/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/lib:/opt/lib64:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=/opt/lib/pkgconfig:/opt/lib64/pkgconfig
ENV CFLAGS="-fexceptions -Wall -O3"
ENV CXXFLAGS="${CFLAGS}"

# Build Tools
RUN yum install -y cmake

# Setup Some Dirs
#
RUN mkdir -p \
    share/lib \
    share/include

# Install expat
#
RUN curl https://codeload.github.com/libexpat/libexpat/zip/R_2_2_9 > libexpat-R_2_2_9.zip && \
    unzip libexpat-R_2_2_9.zip && \
    cd ./libexpat-R_2_2_9/expat && \
    ./buildconf.sh && \
    ./configure --prefix=/opt && \
    make install

RUN cp -a /opt/lib/libexpat.so* /build/share/lib

# Install libpng
#
RUN curl -L https://downloads.sourceforge.net/libpng/libpng-1.6.37.tar.xz > libpng-1.6.37.tar.xz && \
    tar -xf libpng-1.6.37.tar.xz && \
    cd libpng-1.6.37 && \
    ./configure --prefix=/opt --disable-static && \
    make && \
    make install

RUN cp -a /opt/lib/libpng.so* /build/share/lib && \
    cp -a /opt/lib/libpng16.so* /build/share/lib

# Install giflib
#
RUN curl -L https://sourceforge.net/projects/giflib/files/giflib-5.2.1.tar.gz > giflib-5.2.1.tar.gz && \
    tar -xf giflib-5.2.1.tar.gz && \
    cd giflib-5.2.1 && \
    make && \
    make PREFIX=/opt install

RUN cp -a /opt/lib/libgif.so* /build/share/lib

# Install libjpeg-turbo
#
RUN curl -L https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-2.0.4.tar.gz > libjpeg-turbo-2.0.4.tar.gz && \
    tar -xf libjpeg-turbo-2.0.4.tar.gz && \
    cd libjpeg-turbo-2.0.4 && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt && \
    make && \
    make install

RUN cp -a /opt/lib64/libjpeg.so* /build/share/lib && \
    cp -a /opt/lib64/libturbojpeg.so* /build/share/lib

# Install libimagequant
#
RUN git clone https://github.com/ImageOptim/libimagequant.git && \
    cd ./libimagequant && \
    git checkout 2.12.6 && \
    ./configure --prefix=/opt && \
    make libimagequant.so && \
    make install && \
    echo /opt/lib > /etc/ld.so.conf.d/libimagequant.conf && \
    /usr/sbin/ldconfig

RUN cp -a /opt/lib/libimagequant.so* /build/share/lib/

# Install libfftw
#
RUN curl -L http://www.fftw.org/fftw-3.3.8.tar.gz > fftw-3.3.8.tar.gz && \
    tar -xf fftw-3.3.8.tar.gz && \
    cd ./fftw-3.3.8 && \
    ./configure \
      --prefix=/opt \
      --enable-shared \
      --disable-static \
      --enable-threads \
      --enable-sse2 \
      --enable-avx && \
    make && \
    make install

RUN cp -a /opt/lib/libfftw3* /build/share/lib/

# Install liborc (perf)
#
RUN curl -L https://gstreamer.freedesktop.org/data/src/orc/orc-0.4.26.tar.xz > orc-0.4.26.tar.xz && \
    tar -xf orc-0.4.26.tar.xz && \
    cd orc-0.4.26 && \
    ./configure --prefix=/opt && \
    make && \
    make install
RUN cp -a /opt/lib/liborc-0.4.so* /build/share/lib/

# Install libvips. Primary deps https://libvips.github.io/libvips/install.html
#
RUN yum install -y \
    gtk-doc \
    ninja-build

RUN pip3 install meson && \
    pip3 install ninja

RUN curl -L http://ftp.gnome.org/pub/gnome/sources/glib/2.64/glib-2.64.2.tar.xz > glib-2.64.2.tar.xz && \
    tar -xf glib-2.64.2.tar.xz && \
    cd glib-2.64.2 && \
    mkdir ./_build && \
    cd ./_build && \
    meson --prefix=/opt .. && \
    ninja && \
    ninja install

RUN cp -a /opt/lib64/libffi.so* /build/share/lib && \
    cp -a /opt/lib64/libgio-2.0.so* /build/share/lib && \
    cp -a /opt/lib64/libglib-2.0.so* /build/share/lib && \
    cp -a /opt/lib64/libgmodule-2.0.so* /build/share/lib && \
    cp -a /opt/lib64/libgobject-2.0.so* /build/share/lib && \
    cp -a /opt/lib64/libgthread-2.0.so* /build/share/lib

RUN curl -L http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.72/gobject-introspection-1.72.0.tar.xz > gobject-introspection-1.72.0.tar.xz && \
    tar -xf gobject-introspection-1.72.0.tar.xz && \
    cd gobject-introspection-1.72.0 && \
    mkdir ./_build && \
    cd ./_build && \
    meson --prefix=/opt .. && \
    ninja && \
    ninja install

# Install libvips.
#
RUN curl -L https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz > vips-${VIPS_VERSION}.tar.gz && \
    tar -xf vips-${VIPS_VERSION}.tar.gz && \
    cd vips-${VIPS_VERSION} && \
    ./configure \
      --prefix=/opt \
      --disable-gtk-doc \
      --without-magick \
      --with-expat=/opt \
      --with-giflib-includes=/opt/local/include \
      --with-giflib-libraries=/opt/local/lib && \
    make && \
    make install && \
    echo /opt/lib > /etc/ld.so.conf.d/libvips.conf && \
    /usr/sbin/ldconfig

RUN cp -a /opt/lib/libvips.so* /build/share/lib && \
    cp -a /opt/lib/libvips-cpp* /build/share/lib

# Copy all pkgconfig, includes for node sharp build.
#
RUN cp -a /opt/lib/pkgconfig /build/share/lib && \
    cp -a /opt/lib64/pkgconfig/* /build/share/lib/pkgconfig && \
    cp -a /opt/include /build/share && \
    cp -a /opt/lib64/glib-2.0 /build/share/lib

# Store the VIPS_VERSION variable in a file, accessible to the deploy script.
#
RUN echo $VIPS_VERSION > "./share/VIPS_VERSION"

# Create an /build/share/opt/lib64 symlink for shared objects.
#
RUN cd ./share && ln -s lib lib64
