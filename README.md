
# Ruby Libvips Lambda Layer

<a href="https://github.com/customink/lamby"><img src="https://user-images.githubusercontent.com/2381/59363668-89edeb80-8d03-11e9-9985-2ce14361b7e3.png" alt="Lamby: Simple Rails & AWS Lambda Integration using Rack." align="right" width="300" /></a>Are you using the [ruby-vips](https://github.com/libvips/ruby-vips) or [image_processing](https://github.com/janko/image_processing) gems with a Lambda microservice? Maybe you are using [Lamby](https://github.com/customink/lamby) to deploy your entire Rails application to AWS Lambda with its simple Rack integration? If yes to any of the above, this [Lambda Layer](https://aws.amazon.com/blogs/compute/working-with-aws-lambda-and-lambda-layers-in-aws-sam/) is just for you.

**[Lamby: Simple Rails & AWS Lambda Integration using Rack.](https://github.com/customink/lamby)**

## Usage

Ensure you have both Docker installed and your AWS CLI configured. After you clone this repository, please run:

```shell
$ ./bin/deploy
```

This will call `./bin/build` for you and push your built Lambda Layer to your own account. Use the ARN in the script's output within your [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-layers.html) `template.yaml` file. If needed you can use the `AWS_PROFILE` environment variable to control which CLI account is used.

## Ruby 2.7 or 2.5?

The master branch of this repo is targeted for the Ruby 2.7 runtime which is Amazon Linux 2. Most all dependencies needed for `libvips` have to be installed and packaged. Please use the [ruby25](https://github.com/customink/ruby-vips-lambda/tree/ruby25) branch which is Amazon Linux 1 if you use the ruby2.5 runtime.

## Node

Technically this layer can be used with Node for the [sharp](https://sharp.pixelplumbing.com) package. Sharp will detect a global libvips installation and use it during the SAM build steps if you use both build from source and set the `PKG_CONFIG_PATH` to the opt directory. So for example:

```shell
PKG_CONFIG_PATH=/opt/lib/pkgconfig npm install --build-from-source
```

Please reference sharp's [installation instructions](https://sharp.pixelplumbing.com/install) for full details.

## Methodology

Simplicity and small file size! We followed the [docs](https://libvips.github.io/libvips/install.html) for `libvips` install. Our build script uses `lambci/lambda:build-ruby2.7` Docker image from the [docker-lambda](https://github.com/lambci/docker-lambda) project as our build environment. All build commands are located in the `Dockerfile` which install all the dependencies for libvips in the `/opt` directory. This includes common file format openers and savers as well as libs that ensure libvips is fast. The current version built is `8.10.0` and easy to configure by providing the `VIPS_VERSION` environment variable during the build or deploy script.

## Alternatives

The [Yumda](https://github.com/lambci/yumda) project form Serverless Hero Michael Hart recently added libvips package support. It installs both ImageMagick and Libvips and is an excellent alterative to this project. Check it out!

## Contents

Current size of the layer's un-compressed contents is around `32MB` in size. Contents include:

#### /opt/lib

```
drwxr-xr-x 3 root     4096 Sep 21 01:01 glib-2.0/
lrwxrwxrwx 1 root       18 Sep 21 00:54 libexpat.so -> libexpat.so.1.6.11
lrwxrwxrwx 1 root       18 Sep 21 00:54 libexpat.so.1 -> libexpat.so.1.6.11
-rwxr-xr-x 1 root   231496 Sep 21 00:54 libexpat.so.1.6.11
lrwxrwxrwx 1 root       11 Sep 21 01:01 libffi.so -> libffi.so.7
lrwxrwxrwx 1 root       15 Sep 21 01:01 libffi.so.7 -> libffi.so.7.1.0
-rwxr-xr-x 1 root   196304 Sep 21 01:00 libffi.so.7.1.0
-rwxr-xr-x 1 root      926 Sep 21 00:59 libfftw3.la
lrwxrwxrwx 1 root       17 Sep 21 00:59 libfftw3.so -> libfftw3.so.3.5.8
lrwxrwxrwx 1 root       17 Sep 21 00:59 libfftw3.so.3 -> libfftw3.so.3.5.8
-rwxr-xr-x 1 root  2327176 Sep 21 00:59 libfftw3.so.3.5.8
-rwxr-xr-x 1 root     1004 Sep 21 00:59 libfftw3_threads.la
lrwxrwxrwx 1 root       25 Sep 21 00:59 libfftw3_threads.so -> libfftw3_threads.so.3.5.8
lrwxrwxrwx 1 root       25 Sep 21 00:59 libfftw3_threads.so.3 -> libfftw3_threads.so.3.5.8
-rwxr-xr-x 1 root    33968 Sep 21 00:59 libfftw3_threads.so.3.5.8
lrwxrwxrwx 1 root       11 Sep 21 00:55 libgif.so -> libgif.so.7
lrwxrwxrwx 1 root       15 Sep 21 00:55 libgif.so.7 -> libgif.so.7.2.0
-rwxr-xr-x 1 root    36568 Sep 21 00:55 libgif.so.7.2.0
lrwxrwxrwx 1 root       15 Sep 21 01:01 libgio-2.0.so -> libgio-2.0.so.0
lrwxrwxrwx 1 root       22 Sep 21 01:01 libgio-2.0.so.0 -> libgio-2.0.so.0.6400.2
-rwxr-xr-x 1 root 10701792 Sep 21 01:01 libgio-2.0.so.0.6400.2
lrwxrwxrwx 1 root       16 Sep 21 01:01 libglib-2.0.so -> libglib-2.0.so.0
lrwxrwxrwx 1 root       23 Sep 21 01:01 libglib-2.0.so.0 -> libglib-2.0.so.0.6400.2
-rwxr-xr-x 1 root  5742552 Sep 21 01:00 libglib-2.0.so.0.6400.2
lrwxrwxrwx 1 root       19 Sep 21 01:01 libgmodule-2.0.so -> libgmodule-2.0.so.0
lrwxrwxrwx 1 root       26 Sep 21 01:01 libgmodule-2.0.so.0 -> libgmodule-2.0.so.0.6400.2
-rwxr-xr-x 1 root    50400 Sep 21 01:01 libgmodule-2.0.so.0.6400.2
lrwxrwxrwx 1 root       19 Sep 21 01:01 libgobject-2.0.so -> libgobject-2.0.so.0
lrwxrwxrwx 1 root       26 Sep 21 01:01 libgobject-2.0.so.0 -> libgobject-2.0.so.0.6400.2
-rwxr-xr-x 1 root  1856656 Sep 21 01:01 libgobject-2.0.so.0.6400.2
lrwxrwxrwx 1 root       19 Sep 21 01:01 libgthread-2.0.so -> libgthread-2.0.so.0
lrwxrwxrwx 1 root       26 Sep 21 01:01 libgthread-2.0.so.0 -> libgthread-2.0.so.0.6400.2
-rwxr-xr-x 1 root    14840 Sep 21 01:01 libgthread-2.0.so.0.6400.2
lrwxrwxrwx 1 root       18 Sep 21 00:56 libimagequant.so -> libimagequant.so.0
-rw-r--r-- 1 root    62432 Sep 21 00:56 libimagequant.so.0
lrwxrwxrwx 1 root       13 Sep 21 00:56 libjpeg.so -> libjpeg.so.62
lrwxrwxrwx 1 root       17 Sep 21 00:56 libjpeg.so.62 -> libjpeg.so.62.3.0
-rwxr-xr-x 1 root   475448 Sep 21 00:56 libjpeg.so.62.3.0
lrwxrwxrwx 1 root       20 Sep 21 00:59 liborc-0.4.so -> liborc-0.4.so.0.25.0
lrwxrwxrwx 1 root       20 Sep 21 00:59 liborc-0.4.so.0 -> liborc-0.4.so.0.25.0
-rwxr-xr-x 1 root   797976 Sep 21 00:59 liborc-0.4.so.0.25.0
lrwxrwxrwx 1 root       19 Sep 21 00:55 libpng16.so -> libpng16.so.16.37.0
lrwxrwxrwx 1 root       19 Sep 21 00:55 libpng16.so.16 -> libpng16.so.16.37.0
-rwxr-xr-x 1 root   285720 Sep 21 00:55 libpng16.so.16.37.0
lrwxrwxrwx 1 root       11 Sep 21 00:55 libpng.so -> libpng16.so
lrwxrwxrwx 1 root       17 Sep 21 00:56 libturbojpeg.so -> libturbojpeg.so.0
lrwxrwxrwx 1 root       21 Sep 21 00:56 libturbojpeg.so.0 -> libturbojpeg.so.0.2.0
-rwxr-xr-x 1 root   596576 Sep 21 00:55 libturbojpeg.so.0.2.0
-rw-r--r-- 1 root   399402 Sep 21 01:06 libvips-cpp.a
-rwxr-xr-x 1 root     1210 Sep 21 01:06 libvips-cpp.la
lrwxrwxrwx 1 root       22 Sep 21 01:06 libvips-cpp.so -> libvips-cpp.so.42.12.3
lrwxrwxrwx 1 root       22 Sep 21 01:06 libvips-cpp.so.42 -> libvips-cpp.so.42.12.3
-rwxr-xr-x 1 root   257848 Sep 21 01:06 libvips-cpp.so.42.12.3
lrwxrwxrwx 1 root       18 Sep 21 01:06 libvips.so -> libvips.so.42.12.3
lrwxrwxrwx 1 root       18 Sep 21 01:06 libvips.so.42 -> libvips.so.42.12.3
-rwxr-xr-x 1 root  4257200 Sep 21 01:06 libvips.so.42.12.3
drwxr-xr-x 2 root     4096 Sep 21 01:06 pkgconfig/
```

#### /opt/lib/glib-2.0/include

```
-rw-r--r-- 1 root 5678 Sep 21 01:00 glibconfig.h
```

#### /opt/lib/pkgconfig

```
-rw-r--r-- 1 root 226 Sep 21 00:54 expat.pc
-rw-r--r-- 1 root 229 Sep 21 00:59 fftw3.pc
-rw-r--r-- 1 root 698 Sep 21 01:00 gio-2.0.pc
-rw-r--r-- 1 root 234 Sep 21 01:00 gio-unix-2.0.pc
-rw-r--r-- 1 root 375 Sep 21 01:00 glib-2.0.pc
-rw-r--r-- 1 root 256 Sep 21 01:00 gmodule-2.0.pc
-rw-r--r-- 1 root 256 Sep 21 01:00 gmodule-export-2.0.pc
-rw-r--r-- 1 root 275 Sep 21 01:00 gmodule-no-export-2.0.pc
-rw-r--r-- 1 root 279 Sep 21 01:00 gobject-2.0.pc
-rw-r--r-- 1 root 669 Sep 21 01:02 gobject-introspection-1.0.pc
-rw-r--r-- 1 root 632 Sep 21 01:02 gobject-introspection-no-export-1.0.pc
-rw-r--r-- 1 root 225 Sep 21 01:00 gthread-2.0.pc
-rw-r--r-- 1 root 305 Sep 21 00:56 imagequant.pc
-rw-r--r-- 1 root 201 Sep 21 01:00 libffi.pc
-rw-r--r-- 1 root 223 Sep 21 00:55 libjpeg.pc
-rw-r--r-- 1 root 259 Sep 21 00:55 libpng16.pc
lrwxrwxrwx 1 root  11 Sep 21 00:55 libpng.pc -> libpng16.pc
-rw-r--r-- 1 root 235 Sep 21 00:55 libturbojpeg.pc
-rw-r--r-- 1 root 329 Sep 21 00:59 orc-0.4.pc
-rw-r--r-- 1 root 233 Sep 21 01:06 vips-cpp.pc
-rw-r--r-- 1 root 354 Sep 21 01:06 vips.pc
```

#### /opt/include

```
-rw-r--r-- 1 root  3836 Sep 21 00:54 expat_config.h
-rw-r--r-- 1 root  5528 Sep 21 00:54 expat_external.h
-rw-r--r-- 1 root 41473 Sep 21 00:54 expat.h
-rw-r--r-- 1 root   792 Sep 21 01:00 ffi.h
-rw-r--r-- 1 root   840 Sep 21 01:00 ffitarget.h
-rw-r--r-- 1 root  4343 Sep 21 01:00 ffitarget-x86_64.h
-rw-r--r-- 1 root 13481 Sep 21 01:00 ffi-x86_64.h
-rw-r--r-- 1 root  2447 Sep 21 00:59 fftw3.f
-rw-r--r-- 1 root 54596 Sep 21 00:59 fftw3.f03
-rw-r--r-- 1 root 31394 Sep 21 00:59 fftw3.h
-rw-r--r-- 1 root 26983 Sep 21 00:59 fftw3l.f03
-rw-r--r-- 1 root 25682 Sep 21 00:59 fftw3q.f03
-rw-r--r-- 1 root 12986 Sep 21 00:55 gif_lib.h
drwxr-xr-x 3 root  4096 Sep 21 01:01 gio-unix-2.0/
drwxr-xr-x 5 root  4096 Sep 21 01:01 glib-2.0/
drwxr-xr-x 2 root  4096 Sep 21 01:02 gobject-introspection-1.0/
-rw-r--r-- 1 root  2166 Sep 21 00:55 jconfig.h
-rw-r--r-- 1 root 15177 Dec 31  2019 jerror.h
-rw-r--r-- 1 root 15143 Dec 31  2019 jmorecfg.h
-rw-r--r-- 1 root 50281 Dec 31  2019 jpeglib.h
-rw-r--r-- 1 root  6942 Sep 21 00:56 libimagequant.h
drwxr-xr-x 2 root  4096 Sep 21 00:55 libpng16/
drwxr-xr-x 4 root  4096 Sep 21 00:59 orc-0.4/
lrwxrwxrwx 1 root    18 Sep 21 00:55 pngconf.h -> libpng16/pngconf.h
lrwxrwxrwx 1 root    14 Sep 21 00:55 png.h -> libpng16/png.h
lrwxrwxrwx 1 root    21 Sep 21 00:55 pnglibconf.h -> libpng16/pnglibconf.h
-rw-r--r-- 1 root 73889 Dec 31  2019 turbojpeg.h
drwxr-xr-x 2 root  4096 Sep 21 01:06 vips/
```
