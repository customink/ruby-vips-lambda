

## Ruby Libvips Lambda Layer

<a href="https://github.com/customink/lamby"><img src="https://user-images.githubusercontent.com/2381/59363668-89edeb80-8d03-11e9-9985-2ce14361b7e3.png" alt="Lamby: Simple Rails & AWS Lambda Integration using Rack." align="right" width="300" /></a>Are you using the [ruby-vips](https://github.com/libvips/ruby-vips) gem? Maybe you are using the `ImageProcessing::Vips` interface of the fantastic [image_processing](https://github.com/janko/image_processing) gem which Rails v6 & ActiveStorage will use?

Maybe you are using our [Lamby](https://github.com/customink/lamby) infrastructure to deploy your Rails app to AWS Lambda using simple Rack integration and documentation? If yes to any of the above, this [Lambda Layer](https://aws.amazon.com/blogs/compute/working-with-aws-lambda-and-lambda-layers-in-aws-sam/) is just for you.

**[Lamby: Simple Rails & AWS Lambda Integration using Rack.](https://github.com/customink/lamby)**

## Alternatives

The [Yumda](https://github.com/lambci/yumda) project form Serverless Hero Michael Hart recently added libvips package support. It installs both ImageMagick and Libvips and is an excellent alterative to this project. Check it out!


## Usage

* Clone or fork this repository.
* Make sure you have Docker or AWS CLI installed.
* Run `./bin/deploy`

From there you simply use the arn in your AWS SAM `template.yaml` file.


## Methodology

Simplicity and small file size! We followed the [docs](https://libvips.github.io/libvips/install.html) for `libvips` install. But because AWS Lambda already has ImageMagick and lots of the needed dependencies, the work was very basic.

We used the `lambci/lambda:build-ruby2.7` Docker image from the [docker-lambda](https://github.com/lambci/docker-lambda) project. From there we only had to install a few more dependencies to get libvips installed. The current version is `v8.9.2` and easy to configure if you need something else.

Lastly, we were happy to find that `glib` and `gobject` were already installed and all that was needed were some simple sym links so FFI could load these libraries.


## Contents

Current size of the layer's un-compressed contents is around `28MB` in size. Contents include:

```shell
$ ls -lAGp /opt/lib
lrwxrwxrwx 1 root       18 Sep 19 22:46 libexpat.so -> libexpat.so.1.6.11
lrwxrwxrwx 1 root       18 Sep 19 22:46 libexpat.so.1 -> libexpat.so.1.6.11
-rwxr-xr-x 1 root   231496 Sep 19 22:46 libexpat.so.1.6.11
lrwxrwxrwx 1 root       11 Sep 19 22:53 libffi.so -> libffi.so.7
lrwxrwxrwx 1 root       15 Sep 19 22:53 libffi.so.7 -> libffi.so.7.1.0
-rwxr-xr-x 1 root   196304 Sep 19 22:52 libffi.so.7.1.0
-rwxr-xr-x 1 root      926 Sep 19 22:50 libfftw3.la
lrwxrwxrwx 1 root       17 Sep 19 22:50 libfftw3.so -> libfftw3.so.3.5.8
lrwxrwxrwx 1 root       17 Sep 19 22:50 libfftw3.so.3 -> libfftw3.so.3.5.8
-rwxr-xr-x 1 root  2327176 Sep 19 22:50 libfftw3.so.3.5.8
-rwxr-xr-x 1 root     1004 Sep 19 22:50 libfftw3_threads.la
lrwxrwxrwx 1 root       25 Sep 19 22:50 libfftw3_threads.so -> libfftw3_threads.so.3.5.8
lrwxrwxrwx 1 root       25 Sep 19 22:50 libfftw3_threads.so.3 -> libfftw3_threads.so.3.5.8
-rwxr-xr-x 1 root    33968 Sep 19 22:50 libfftw3_threads.so.3.5.8
lrwxrwxrwx 1 root       11 Sep 19 22:46 libgif.so -> libgif.so.7
lrwxrwxrwx 1 root       15 Sep 19 22:46 libgif.so.7 -> libgif.so.7.2.0
-rwxr-xr-x 1 root    36568 Sep 19 22:46 libgif.so.7.2.0
lrwxrwxrwx 1 root       15 Sep 19 22:53 libgio-2.0.so -> libgio-2.0.so.0
lrwxrwxrwx 1 root       22 Sep 19 22:53 libgio-2.0.so.0 -> libgio-2.0.so.0.6400.2
-rwxr-xr-x 1 root 10701792 Sep 19 22:53 libgio-2.0.so.0.6400.2
lrwxrwxrwx 1 root       16 Sep 19 22:53 libglib-2.0.so -> libglib-2.0.so.0
lrwxrwxrwx 1 root       23 Sep 19 22:53 libglib-2.0.so.0 -> libglib-2.0.so.0.6400.2
-rwxr-xr-x 1 root  5742552 Sep 19 22:52 libglib-2.0.so.0.6400.2
lrwxrwxrwx 1 root       19 Sep 19 22:53 libgmodule-2.0.so -> libgmodule-2.0.so.0
lrwxrwxrwx 1 root       26 Sep 19 22:53 libgmodule-2.0.so.0 -> libgmodule-2.0.so.0.6400.2
-rwxr-xr-x 1 root    50400 Sep 19 22:53 libgmodule-2.0.so.0.6400.2
lrwxrwxrwx 1 root       19 Sep 19 22:53 libgobject-2.0.so -> libgobject-2.0.so.0
lrwxrwxrwx 1 root       26 Sep 19 22:53 libgobject-2.0.so.0 -> libgobject-2.0.so.0.6400.2
-rwxr-xr-x 1 root  1856656 Sep 19 22:53 libgobject-2.0.so.0.6400.2
lrwxrwxrwx 1 root       19 Sep 19 22:53 libgthread-2.0.so -> libgthread-2.0.so.0
lrwxrwxrwx 1 root       26 Sep 19 22:53 libgthread-2.0.so.0 -> libgthread-2.0.so.0.6400.2
-rwxr-xr-x 1 root    14840 Sep 19 22:53 libgthread-2.0.so.0.6400.2
lrwxrwxrwx 1 root       18 Sep 19 22:47 libimagequant.so -> libimagequant.so.0
-rw-r--r-- 1 root    62432 Sep 19 22:47 libimagequant.so.0
lrwxrwxrwx 1 root       13 Sep 19 22:47 libjpeg.so -> libjpeg.so.62
lrwxrwxrwx 1 root       17 Sep 19 22:47 libjpeg.so.62 -> libjpeg.so.62.3.0
-rwxr-xr-x 1 root   475448 Sep 19 22:47 libjpeg.so.62.3.0
lrwxrwxrwx 1 root       20 Sep 19 22:51 liborc-0.4.so -> liborc-0.4.so.0.25.0
lrwxrwxrwx 1 root       20 Sep 19 22:51 liborc-0.4.so.0 -> liborc-0.4.so.0.25.0
-rwxr-xr-x 1 root   797976 Sep 19 22:51 liborc-0.4.so.0.25.0
lrwxrwxrwx 1 root       19 Sep 19 22:46 libpng16.so -> libpng16.so.16.37.0
lrwxrwxrwx 1 root       19 Sep 19 22:46 libpng16.so.16 -> libpng16.so.16.37.0
-rwxr-xr-x 1 root   285720 Sep 19 22:46 libpng16.so.16.37.0
lrwxrwxrwx 1 root       11 Sep 19 22:46 libpng.so -> libpng16.so
lrwxrwxrwx 1 root       17 Sep 19 22:47 libturbojpeg.so -> libturbojpeg.so.0
lrwxrwxrwx 1 root       21 Sep 19 22:47 libturbojpeg.so.0 -> libturbojpeg.so.0.2.0
-rwxr-xr-x 1 root   596576 Sep 19 22:47 libturbojpeg.so.0.2.0
lrwxrwxrwx 1 root       18 Sep 19 22:58 libvips.so -> libvips.so.42.12.3
lrwxrwxrwx 1 root       18 Sep 19 22:58 libvips.so.42 -> libvips.so.42.12.3
-rwxr-xr-x 1 root  4257200 Sep 19 22:58 libvips.so.42.12.3

$ ls -lAGp /opt/include
-rw-r--r-- 1 root     6942 Sep 19 22:47 libimagequant.h
```
