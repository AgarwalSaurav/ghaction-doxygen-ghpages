FROM archlinux:latest

LABEL org.opencontainers.image.source=https://github.com/AgarwalSaurav/ghaction-doxygen-ghpages
LABEL org.opencontainers.image.description="Doxygen documentation generator with Python and LaTeX support"
LABEL org.opencontainers.image.licenses=MIT

# Install dependencies and clean up in a single layer to reduce image size
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
      base-devel \
      git \
      graphviz \
      doxygen \
      python \
      python-pip \
      texlive-core \
      texlive-latexextra \
      texlive-fontsextra && \
    python -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir doxypypy && \
    rm -rf /var/cache/pacman/pkg/* \
           /var/lib/pacman/sync/* \
           /etc/pacman.d/gnupg

# Copy and set up entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
