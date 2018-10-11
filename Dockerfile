FROM jboss-eap-7/eap71-openshift:latest 
RUN mkdir blub
COPY sample.war /tmp
COPY test/* /tmp
RUN sleep 10000
EXPOSE 8080
CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0"]
