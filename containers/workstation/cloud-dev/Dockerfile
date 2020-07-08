FROM archlinux/base
ENV MYUSER dev
RUN useradd -m ${MYUSER}
RUN pacman -Syyu --noconfirm
RUN pacman -S terraform \
              git \
              coreutils \
              procps-ng \
              bind-tools \
              nano \
              tree \
              tmux \
              openssh\
               --noconfirm
WORKDIR /home/${MYUSER}/workdir
USER ${MYUSER}
ENTRYPOINT /bin/bash
