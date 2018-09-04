FROM eap-70-openshift:latest
COPY sample.war /opt/eap/standalone/deployments/ROOT.war
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
