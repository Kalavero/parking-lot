FROM ruby:2.6

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

ENV APP_PATH=/parking_lot

RUN mkdir $APP_PATH
WORKDIR $APP_PATH
COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock

ENV BUNDLE_PATH=/gems BUNDLE_JOBS=3 BUNDLE_APP_CONFIG=$APP_PATH/.bundle/
RUN mkdir -p $BUNDLE_PATH
RUN bundle install

ADD . $APP_PATH

VOLUME $BUNDLE_PATH
