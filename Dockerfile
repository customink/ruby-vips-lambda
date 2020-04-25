FROM lambci/lambda:build-ruby2.5

WORKDIR /build

ARG VIPS_VERSION=8.9.1
ARG IMAGEQUANT_VERSION=2.12.6

ENV WORKDIR="/build"
ENV INSTALLDIR="/opt"
ENV VIPS_VERSION=$VIPS_VERSION
ENV IMAGEQUANT_VERSION=$IMAGEQUANT_VERSION

# Setup Some Dirs
#
RUN mkdir -p \
    share/lib \
    share/include

# Install libimagequant. Details: https://github.com/libvips/libvips/pull/1009
#
RUN git clone git://github.com/ImageOptim/libimagequant.git && \
    cd ./libimagequant && \
    git checkout "${IMAGEQUANT_VERSION}" && \
    CC=clang CXX=clang++ ./configure --prefix=/opt && \
    make libimagequant.so && \
    make install && \
    echo /opt/lib > /etc/ld.so.conf.d/libimagequant.conf && \
    ldconfig
RUN cp -a $INSTALLDIR/lib/libimagequant.so* $WORKDIR/share/lib/ && \
    cp -a $INSTALLDIR/include/libimagequant.h $WORKDIR/share/include/


# Install deps for libvips. Details: https://libvips.github.io/libvips/install.html
#
RUN yum install -y \
  gtk-doc \
  gobject-introspection \
  gobject-introspection-devel

# Clone repo and checkout version tag.
#
RUN git clone git://github.com/libvips/libvips.git && \
  cd libvips && \
  git checkout "v${VIPS_VERSION}"

# Compile from source.
#
RUN cd ./libvips && \
  CC=clang CXX=clang++ \
  IMAGEQUANT_CFLAGS="-I/opt/include" \
  IMAGEQUANT_LIBS="-L/opt/lib -limagequant" \
  ./autogen.sh \
  --prefix=${INSTALLDIR} \
  --disable-static && \
  make install && \
  echo /opt/lib > /etc/ld.so.conf.d/libvips.conf && \
  ldconfig

# Copy only needed so files to new share/lib.
#
RUN mkdir -p share/lib && \
  cp -a $INSTALLDIR/lib/libvips.so* $WORKDIR/share/lib/

# Create sym links for ruby-ffi gem's `glib_libname` and `gobject_libname` to work.
RUN cd ./share/lib/ && \
  ln -s /usr/lib64/libglib-2.0.so.0 libglib-2.0.so && \
  ln -s /usr/lib64/libgobject-2.0.so.0 libgobject-2.0.so

# Zip up contents so final `lib` can be placed in /opt layer.
#
RUN cd ./share && \
  zip --symlinks -r libvips.zip .

# Store the VIPS_VERSION variable in a file, accessible to the deploy script.
#
RUN echo VIPS_VERSION=$VIPS_VERSION >> $WORKDIR/share/.env
