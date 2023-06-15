# Dockerfile to build/generate gh2md pages (to be intgerated with rear-user-guide)
#
# To build the docker container:
# 
# docker build -t gh2md .
# or use another user then the default 'gdha' (with another uid) use:
# docker build --build-arg local_user=gdha --build-arg local_id=1002 -t gh2md .
#
# The first time run of the 'gh2md' container:
# docker run -it -v $HOME/projects/rear/rear-user-guide:$HOME/web \
#                -v $HOME/.gitconfig:$HOME/.gitconfig -v $HOME/.ssh:$HOME/.ssh \
#                -v $HOME/.gnupg:$HOME/.gnupg -v $HOME/.github-token:$HOME/.github-token --net=host gh2md
# Afterwards we can just start the container as:
# docker start -i gh2md


FROM ubuntu:20.04
ARG local_user=gdha
ARG local_id=1002
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    python3 \
    python3-distutils \
    make \
    gcc \
    curl \
    ca-certificates \
    git \
    openssh-client \
    gnupg \
    locales \
    vim \
    pandoc \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install pip and mkdocs + extras; remove gcc afterwards again
RUN curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \ 
    && python3 /tmp/get-pip.py \
    && pip install --upgrade pip \
    && pip install gh2md \
    && apt autoremove \
    && apt-get -y remove gcc

COPY convert_gfm2md.sh /usr/bin/convert_gfm2md.sh
COPY run_gh2md.sh /usr/bin/run_gh2md.sh

RUN echo "Setting home directory for local user ${local_user}" \
    && useradd -u ${local_id} ${local_user} \
    && mkdir -p /home/${local_user}/web/ \
    && chown -R ${local_user}:${local_user} /home/${local_user}/web

# Needed to make nerdtree plugin for vim work and git credential.helper
RUN locale-gen en_US.UTF-8 && \
    echo "export LC_CTYPE=en_US.UTF-8" >> /home/${local_user}/.bashrc && \
    echo "export LC_ALL=en_US.UTF-8" >> /home/${local_user}/.bashrc

# Prepare Github2markdown run
RUN echo "Prepare for gh2md/pandoc run" \
    && chmod +x /usr/bin/convert_gfm2md.sh \
    && chmod +x /usr/bin/run_gh2md.sh

WORKDIR /home/${local_user}/web
USER ${local_user}
#CMD gh2md --multiple-files --idempotent --file-extension .gfm rear/rear issues && /usr/bin/convert_gfm2md.sh
CMD /usr/bin/run_gh2md.sh
