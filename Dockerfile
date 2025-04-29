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

# Instala apenas os pacotes essenciais do XFCE e dependências necessárias para o VNC e X11
RUN apt-get update && apt-get install --no-install-recommends -y \
    xfce4-session \
    xfce4-panel \
    xfce4-terminal \
    xfce4-settings \
    tightvncserver \
    novnc \
    websockify \
    xterm \
    xkb-data \
    dbus-x11 \
    x11-xserver-utils \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi \
    xserver-xorg-input-all \   # Pacote para os drivers de entrada
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia o script de inicialização gráfica
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Expõe a porta noVNC
EXPOSE 6080

# Inicia o XFCE + noVNC
CMD ["/usr/local/bin/startup.sh"]
