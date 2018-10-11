FROM centos:7
USER root
RUN localedef -i de_DE -f CP1252 de_DE.CP1252


RUN mkdir blub
COPY sample.war /tmp
COPY test/* /tmp
RUN sleep 10000
EXPOSE 8080
CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0"]
