# Start with a base image Python 3.9.12 Debian 11 (bullseye) slim 
FROM python:3.9.12-slim-bullseye

# Add the external tasks directory into /tasks
ADD tasks /tasks

# Install the required dependencies via pip
RUN pip install -r /tasks/requirements.txt

# Expose the required Locust ports
EXPOSE 5557 5558 8089

# Set script to be executable
RUN chmod 755 /tasks/run.sh

# Start Locust using LOCUS_OPTS environment variable
ENTRYPOINT ["/tasks/run.sh"] 
