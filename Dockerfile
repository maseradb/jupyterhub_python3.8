# Use Ubuntu as base, then install JupyterHub and Python 3.8.20
FROM ubuntu:20.04


# Install Python 3.8.20 and dependencies (non-interactive)
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.8 \
    wget \
    build-essential \
    git \
    curl \
    zlib1g-dev \
    libssl-dev \
    libffi-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    openjdk-17-jre-headless \
    software-properties-common && \
    ln -sf /usr/bin/python3.8 /usr/bin/python3 && \
    apt-get install -y python3-pip

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN python3 -m pip install --upgrade pip

# Install JupyterHub and JupyterLab
RUN pip3 install jupyterhub==4.1.5 notebook jupyterlab && \
    pip3 install jupyterhub-nativeauthenticator && \
    pip3 install jupyterlab-git

RUN mkdir -p /srv/jupyterhub/work && chmod 777 /srv/jupyterhub/work

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

COPY jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs && npm install -g configurable-http-proxy

CMD ["jupyterhub", "-f", "/etc/jupyterhub/jupyterhub_config.py"]