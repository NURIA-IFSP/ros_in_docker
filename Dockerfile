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

# Instala dependências básicas do ambiente gráfico e ferramentas
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    ca-certificates \
    git \
    python3 \
    python3-pip \
    dbus-x11 \
    xfce4-session \
    xfce4-panel \
    xfce4-terminal \
    xfce4-settings \
    xterm \
    xkb-data \
    x11-xserver-utils \
    x11-xkb-utils \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi \
    xserver-xorg-input-all \
    libjpeg-turbo8 \
    libxtst6 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala TurboVNC via .deb diretamente
RUN wget https://sourceforge.net/projects/turbovnc/files/3.1.1/turbovnc_3.1.1_amd64.deb && \
    dpkg -i turbovnc_3.1.1_amd64.deb && \
    rm turbovnc_3.1.1_amd64.deb

# Instala o noVNC manualmente
RUN mkdir -p /opt/novnc && \
    git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# Copia o script de inicialização
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 6080

CMD ["/usr/local/bin/startup.sh"]


