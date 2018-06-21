FROM selenium/node-chrome-debug:3.6

ENV HOME=/home/seluser

USER root

COPY ./contrib /usr/local/bin

RUN chown -R 1001:0 /opt/selenium && \
  /usr/local/bin/fix-permissions /opt/selenium && \
  /usr/local/bin/fix-permissions $HOME

USER 1001
WORKDIR $HOME
