# Use a lightweight base image
FROM python:3.7-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    postgresql \
    docker.io \
    curl \
    git \
    make \
    libc-dev \
    libffi-dev \
    libssl-dev \
    wget \
    bash \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install AWS CLI
RUN pip install --upgrade pip \
    && pip install awscli \
    && pip install virtualenv \
    && pip install yasha

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV LANG=C.UTF-8 \
    PATH="/usr/local/bin:${PATH}"

CMD ["bash"]
