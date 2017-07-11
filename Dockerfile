FROM tomcat
 
# Install JDK, Mavan, and Git
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      git \
      openjdk-8-jdk-headless \
      maven && \
    apt-get -qq autoremove && \
    apt-get -qq autoclean && \
    apt-get -qq clean all && \
    rm -rf /var/cache/apk/*
 
# Build OntoSoft from source
RUN git clone https://github.com/IKCAP/ontosoft
WORKDIR ontosoft
RUN mvn clean install
 
# Copy build output to tomcat
RUN mv server/target/ontosoft-*.war client/target/ontosoft-*.war /usr/local/tomcat/webapps/
