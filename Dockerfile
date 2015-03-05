FROM debian:jessie
MAINTAINER Gerardo Rochín <gerardorochin@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y \
        curl \
        git \
        vim

COPY . /root/.dotfiles
RUN cd /root/.dotfiles \
    && bash scripts/git.sh \
    && bash scripts/vim.sh \

CMD ["bash"]
