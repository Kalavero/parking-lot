FROM ruby:2.7

ARG UID

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

ENV APP_USER=parking_lot APP_PATH=/parking_lot

RUN mkdir $APP_PATH && useradd -u $UID --home-dir $APP_PATH $APP_USER

WORKDIR $APP_PATH
COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock

ENV BUNDLE_PATH=/gems BUNDLE_JOBS=3 BUNDLE_APP_CONFIG=$APP_PATH/.bundle/
RUN mkdir -p $BUNDLE_PATH
RUN chown $UID $BUNDLE_PATH
RUN bundle install

ADD . $APP_PATH

VOLUME $BUNDLE_PATH
