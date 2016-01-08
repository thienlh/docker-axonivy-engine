FROM ubuntu:14.04
MAINTAINER Daniel Gauch <daniel@gauch.biz>

# Install wget and unzip 
RUN sudo apt-get update
RUN sudo apt-get install -y wget
RUN sudo apt-get install -y unzip 

# Download and extract Axon.ivy Engine
RUN sudo wget http://download.axonivy.com/6.0.1/AxonIvyEngine6.0.1.50844_Linux_x64.zip
RUN sudo unzip AxonIvyEngine6.0.1.50844_Linux_x64.zip -d /opt/AxonIvyEngine6
RUN sudo rm -f AxonIvyEngine6.0.1.50844_Linux_x64.zip

COPY start-axonivy-engine.sh /usr/local/bin/start-axonivy-engine.sh
RUN chmod +x /usr/local/bin/*.sh

# Fix for issue #25527. Remove as soon as fixed.
RUN sed -i 's/\-djava\.awt\.headless=true/-Djava.awt.headless=true/g' /opt/AxonIvyEngine6/bin/AxonIvyEngine.conf

VOLUME /data

EXPOSE 8081

CMD start-axonivy-engine.sh
