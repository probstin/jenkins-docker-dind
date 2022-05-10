FROM jenkins/jenkins:latest

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yml

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY casc.yml /var/jenkins_home/casc.yml

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt