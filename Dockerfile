# This is an attempt to recreate what Fabian had shown, i.e. a lightweight container
# does not work!
FROM ubuntu:latest

# Pfad ist vieles, aber noch nicht final
COPY ./git-repos/qgis/QGIS /home/dev/cpp/QGIS
COPY ./compile_qgis.sh compile_qgis.sh

ENV DEBIAN_FRONTEND=noninteractive
ENV QT_QPA_PLATFORM=offscreen
ENV XDG_RUNTIME_DIR='/tmp/runtime-root'

# rename script to compile-qgis_process.sh to show its intend (to only compile qgis_process)
RUN bash compile_qgis.sh

RUN rm -rf /home/*
RUN rm /complile_qgis.sh

CMD ["uname"]
