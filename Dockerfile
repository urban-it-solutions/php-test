FROM jboss-eap-7/eap71-openshift:latest 
#RUN mkdir blub
COPY sample.war /tmp
COPY test/* /tmp
EXPOSE 8080
CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0"]
