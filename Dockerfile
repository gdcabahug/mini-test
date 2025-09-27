FROM ubuntu:latest

RUN apt-get update -y && apt-get install jq -y && apt-get clean

WORKDIR /opt/app

COPY scheduler.sh /opt/app

RUN chmod +x scheduler.sh

CMD ["bash", "scheduler.sh"]
