FROM ruby:2.5.1-alpine
LABEL maintainer="ryuckel"

ENV LANG C.UTF-8
ENV ROOT_PATH /app
RUN mkdir $ROOT_PATH
WORKDIR $ROOT_PATH

COPY Gemfile Gemfile.lock ./

RUN apk update && \
    apk add --update --no-cache --virtual=.build-dep \
      build-base \
      linux-headers \
      ruby-dev \
      yaml-dev \
      sqlite-dev \
      zlib-dev && \
    apk add --update --no-cache \
      bash \
      less \
      git \
      openssh \
      sqlite-libs \
      tzdata \
      nodejs \
      ruby-json \
      yaml && \
    bundle install --jobs=4 && \
    apk del .build-dep

STOPSIGNAL SIGQUIT
CMD ["./bootstrap.sh"]

