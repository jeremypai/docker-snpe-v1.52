FROM ubuntu:18.04

WORKDIR /snpe-v1.52

COPY requirements.txt /snpe-v1.52

RUN DEBIAN_FRONTEND=noninteractive && \
    apt update && apt install -y --no-install-recommends python3.6 python3-pip libpython3.6 python3-dev python3-setuptools libc++-9-dev libatomic1 && \
    pip3 install --upgrade pip --no-cache-dir && \
    pip3 install -r requirements.txt --no-cache-dir && \
    rm requirements.txt && \
    apt clean && rm -rf /var/lib/apt/lists/*