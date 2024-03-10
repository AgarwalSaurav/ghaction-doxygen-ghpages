FROM archlinux:latest
LABEL org.opencontainers.image.source https://github.com/AgarwalSauravAgarwal/ghaction-doxygen-ghpages
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel
RUN pacman -S --noconfirm git graphviz doxygen python python-pip
RUN pacman -S --noconfirm texlive-core texlive-latexextra texlive-fontsextra
RUN python -m venv /opt/venv
RUN /opt/venv/bin/pip install doxypypy
RUN rm -rf /var/cache/pacman/pkg/*
RUN rm -rf /var/lib/pacman/sync/*
RUN rm -rf /etc/pacman.d/gnupg

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
