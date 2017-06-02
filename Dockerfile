FROM google/dart:1.24.0-dev.6.6

# Required for flutter install
RUN apt-get update && \
  apt-get install -y unzip

# Used to ensure actions from this container are not seen as "typical" users
ENV PUB_ENVIRONMENT="bot.pkg_pana.docker"
ENV PATH="/flutter/bin:${PATH}"

# Running `flutter config --no-analytics` downloads the Dart SDK and
# disables analytics tracking – which we always want
RUN git clone https://github.com/flutter/flutter.git && \
  flutter config --no-analytics

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
ADD . /app
RUN pub get --offline

ENTRYPOINT ["/usr/bin/dart", "bin/main.dart"]
