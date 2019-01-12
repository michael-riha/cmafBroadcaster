FROM ubuntu:18.04
LABEL Maintainer="Michael Riha <michael.riha@bitmovin.com> (rihabitmovin/cmafbroadcaster)"

RUN apt-get update && apt-get install -y \
  sudo \
  python-minimal \
  python-pip \
  wget \
  apache2 \
  apache2-dev
  #apache2-utils
  #&& mkdir /tmp

#https://vsupalov.com/docker-arg-env-variable-guide/
ENV OUTPUT_FOLDER="/out"
ENV STREAM="with_audio"


COPY install_scripts /tmp
COPY test_scripts /tmp
COPY server /srv

# https://stackoverflow.com/questions/27701930/add-user-to-docker-container wsgi can not run as root!
RUN useradd -ms /bin/bash wsgi \
    && sudo adduser wsgi sudo \
    && chown wsgi:wsgi -R tmp \
    && chmod -R +x tmp \
    && chown wsgi:wsgi -R /srv \
    && passwd wsgi -d \
    #even create the output
    && sudo mkdir $OUTPUT_FOLDER \
    && sudo chown wsgi:wsgi -R $OUTPUT_FOLDER \
    && sudo chmod g+rw -R $OUTPUT_FOLDER \
    && ls -la $OUTPUT_FOLDER

VOLUME ["/out"]
VOLUME ["/tmp/test_scripts/playlists"]

RUN sh /tmp/install.sh # install ffmpeg prebuild and python stuff

#https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container
USER wsgi

# Make port 8000 available to the world outside this container
EXPOSE 8000

ENTRYPOINT ["/tmp/startServer.sh"]
