
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

## Methodology

Simplicity and small file size! We followed the [docs](https://libvips.github.io/libvips/install.html) for `libvips` install. Our build script uses `lambci/lambda:build-ruby2.7` Docker image from the [docker-lambda](https://github.com/lambci/docker-lambda) project as our build environment. All build commands are located in the `Dockerfile` which install all the dependencies for libvips in the `/opt` directory. This includes common file format openers and savers as well as libs that ensure libvips is fast. The current version built is `8.10.0` and easy to configure by providing the `VIPS_VERSION` environment variable during the build or deploy script. 

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

## Alternatives

The [Yumda](https://github.com/lambci/yumda) project form Serverless Hero Michael Hart recently added libvips package support. It installs both ImageMagick and Libvips and is an excellent alterative to this project. Check it out!

