FROM docker.io/fedora:29

LABEL MAINTAINER Domen Blenkuš <domen@blenkus.com>

WORKDIR /srv/lactoject/

COPY lactoject lactoject
COPY manage.py requirements.txt /srv/lactoject/


RUN chmod +x manage.py && \
    rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-29-x86_64 && \
    dnf install -y --setopt=tsflags=nodocs \
      git \
      gcc \
      python3-devel && \
    pip3 install -r /srv/lactoject/requirements.txt && \
    dnf remove -y \
      git \
      gcc \
      python3-devel && \
    dnf install -y --setopt=tsflags=nodocs \
      texlive-scheme-basic  \
      texlive-collection-pictures \
      texlive-collection-xetex \
      texlive-makecell && \
    dnf clean all && \
    adduser --system --create-home --home-dir /home/django django && \
    chown django: /srv/lactoject/

USER django

ENTRYPOINT ["/srv/lactoject/manage.py"]
