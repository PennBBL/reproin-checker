#flywheel/fmriprep

FROM pennbbl/fw-heudiconv:latest
MAINTAINER Matt Cieslak <matthew.cieslak@pennmedicine.upenn.edu>

# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0
RUN mkdir -p ${FLYWHEEL}
COPY manifest.json ${FLYWHEEL}/manifest.json

# Set the entrypoint
ENTRYPOINT ["/flywheel/v0/reproin_checker_run.py"]

COPY reproin_checker_run.py /flywheel/v0/reproin_checker_run.py
RUN chmod +x ${FLYWHEEL}/*

# ENV preservation for Flywheel Engine
RUN env -u HOSTNAME -u PWD | \
  awk -F = '{ print "export " $1 "=\"" $2 "\"" }' > ${FLYWHEEL}/docker-env.sh

WORKDIR /flywheel/v0
