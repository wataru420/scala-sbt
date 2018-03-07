#
# Scala and sbt Dockerfile
#
# https://github.com/wataru420/scala-sbt
#

# Pull base image
FROM openjdk:9

# Env variables
ENV SCALA_VERSION 2.12.4
ENV SBT_VERSION 1.1.1

# Scala expects this file
#RUN touch /usr/lib/jvm/java-9-openjdk-amd64/release

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

# Install SBT
RUN \
  curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /root/ && \
  mkdir -p /root/.ivy2/local/ && \
  cp -r ~/sbt/lib/local-preloaded/* /root/.ivy2/local/

ENV PATH ~/scala-$SCALA_VERSION/bin:/root/sbt/bin:$PATH

RUN sbt sbtVersion

# Define working directory
WORKDIR /root
