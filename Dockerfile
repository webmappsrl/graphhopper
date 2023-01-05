FROM israelhikingmap/graphhopper:latest

RUN apt-get install -y wget

WORKDIR /graphhopper

COPY . .

ENV JAVA_OPTS "-Xmx8g -Xms8g"

RUN mkdir -p /data

WORKDIR /graphhopper

COPY ./config-lunet.yml ./

COPY ./graphhopper.sh ./

VOLUME [ "/data" ]

EXPOSE 8989

HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:8989/health || exit 1

ENTRYPOINT [ "./graphhopper.sh", "-c", "config-lunet.yml" ]