# Ruby Libvips Lambda Layer

<a href="https://github.com/customink/lamby"><img src="https://user-images.githubusercontent.com/2381/59363668-89edeb80-8d03-11e9-9985-2ce14361b7e3.png" alt="Lamby: Simple Rails & AWS Lambda Integration using Rack." align="right" width="300" /></a>Are you using the [ruby-vips](https://github.com/libvips/ruby-vips) or [image_processing](https://github.com/janko/image_processing) gems with a Lambda microservice? Maybe you are using [Lamby](https://github.com/customink/lamby) to deploy your entire Rails application to AWS Lambda with its simple Rack integration? If yes to any of the above, this [Lambda Layer](https://aws.amazon.com/blogs/compute/working-with-aws-lambda-and-lambda-layers-in-aws-sam/) is just for you.

**[Lamby: Simple Rails & AWS Lambda Integration using Rack.](https://github.com/customink/lamby)**

## Installation

This project assumes the use of Lambda Containers. It uses a bare `alpine` Docker image to distribute the `/opt` directory contents which can be installed easily within your project. Please browse this project's [Layer Containers](https://github.com/orgs/customink/packages?repo_name=ruby-vips-lambda&q=layer) for a matching version number. For example:

```dockerfile
FROM ghcr.io/customink/ruby-vips-lambda-layer:8.12.2.1 AS ruby-vips-lambda
FROM public.ecr.aws/lambda/ruby:2.7
COPY --from=ruby-vips-lambda /opt /opt
```

## Amazon Linux 2

The master branch of this repo is targeted for the Amazon Linux 2. Most all dependencies needed for `libvips` have to be installed and packaged. Please reference sharp's [installation instructions](https://sharp.pixelplumbing.com/install) for full details.

## Methodology

Simplicity, isolation, and compact! We followed the [docs](https://libvips.github.io/libvips/install.html) for `libvips` install. Our build script uses `public.ecr.aws/sam/build-nodejs16.x` Docker image from the [Amazon ECR Public Gallery](https://gallery.ecr.aws) project as our build environment. All build commands are located in the `Dockerfile` which install all the dependencies for libvips in the `/opt` directory. This includes common file format openers and savers as well as libs that ensure libvips is fast. The current version built is `8.12.2` and easy to configure by providing the `VIPS_VERSION` environment variable during the build and deploy scripts.

## Build

If you wanted to build your own `/opt` directory contents for a Lambda Layer usable by the ZIP packaging formation. You can build the project like so after cloning it. Make sure you have Docker installed.

```shell
VIPS_VERSION=8.12.2 PACKAGE_VERSION=1 ./bin/build
```

## Contents

Current size of the layer's `/opt` directory is around around `32MB` in size. To see view the contents, exec into one of the [Layer Containers](https://github.com/orgs/customink/packages?repo_name=ruby-vips-lambda&q=layer)
