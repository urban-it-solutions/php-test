FROM jboss-eap-7/eap71-openshift:latest

EXPOSE 8080
CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0"]
