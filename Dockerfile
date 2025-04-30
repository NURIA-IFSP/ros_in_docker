# MIT License
#
# Copyright (c) 2022 Ignacio Vizzo
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
FROM ignaciovizzo/ros_in_docker:noetic

LABEL maintainer="NURIA <nuria@ifsp.edu.br>"

ENV DEBIAN_FRONTEND=noninteractive

# Adiciona o repositório oficial do TurboVNC
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates && \
    wget -qO - https://packagecloud.io/dcommander/turbovnc/gpgkey | gpg --dearmor -o /usr/share/keyrings/turbovnc-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/turbovnc-archive-keyring.gpg] https://packagecloud.io/dcommander/turbovnc/ubuntu/ focal main" \
    > /etc/apt/sources.list.d/turbovnc.list

# Instala XFCE + TurboVNC + noVNC + dependências
RUN apt-get update && apt-get install --no-install-recommends -y \
    xfce4-session \
    xfce4-panel \
    xfce4-terminal \
    xfce4-settings \
    turbovnc \
    novnc \
    websockify \
    xterm \
    xkb-data \
    dbus-x11 \
    x11-xserver-utils \
    x11-xkb-utils \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi \
    xserver-xorg-input-all \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia o script de inicialização gráfica
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Expõe a porta noVNC
EXPOSE 6080

# Inicia XFCE + noVNC
CMD ["/usr/local/bin/startup.sh"]
