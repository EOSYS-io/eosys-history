FROM ruby:2.5.1-slim

ENV RACK_ENV production

RUN apt-get update -qq && apt-get install -y build-essential
RUN gem update bundler

ARG MONGODB_USER
ARG MONGODB_PASSWORD

ENV MONGODB_USER ${MONGODB_USER}
ENV MONGODB_PASSWORD ${MONGODB_PASSWORD}

ENV BUNDLE_DIR /bundle
ENV APP_DIR /app

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
COPY . $APP_DIR
RUN bundle install --with production --path $BUNDLE_DIR

CMD ["/usr/local/bundle/bin/bundle", "exec", "puma", "-b", "tcp://0.0.0.0:80"]
