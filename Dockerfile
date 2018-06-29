FROM ubuntu:trusty
LABEL maintainer="Alex Koepke <akoepke@usdigitalpartners.net"

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to closest
RUN sed -i "s/http:\/\/us./http:\/\/mirrors.archive./g" /etc/apt/sources.list

# Install Ansible
RUN apt-get update -qy && \
    apt-get install -qy software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update -qy && \
    apt-get install -qy ansible

# Add volume for Ansible playbooks
VOLUME [ "/ansible" ]
WORKDIR /ansible

# Entrypoint
ENTRYPOINT [ "ansible-playbook" ]
CMD ["site.yml"]