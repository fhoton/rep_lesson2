FROM ubuntu:latest

LABEL maintainer="alexey.granat@gmail.com"

ENV Status="text"
ENV datex="20.08.2022"

RUN apt-get update
RUN apt-get install -qy python3

COPY ./Lesson12 ./Jenkins

RUN apt-get install -qy net-tools

#install&run Jenkins
EXPOSE 8080
RUN apt-get install -qy curl
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
RUN apt-get update && apt-get install -qy fontconfig openjdk-11-jre && apt-get install -qy jenkins
RUN service jenkins start

VOLUME [ "/devops_volume" ]

COPY ./Lesson5 ./runsh
CMD ["sh","/runsh/execut.sh"]

#docker run -p 8080:8080 -it --rm -v "/home/alex/git/devops/DevOps_learning/Lesson7:/devops_volume" IMAGE_ID


