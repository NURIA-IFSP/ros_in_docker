#!/bin/bash
export DISPLAY=:1

# Cria diretório e senha do VNC se necessário
mkdir -p ~/.vnc
if [ ! -f ~/.vnc/passwd ]; then
    echo "rosvnc" | /opt/TurboVNC/bin/vncpasswd -f > ~/.vnc/passwd
    chmod 600 ~/.vnc/passwd
fi

# Finaliza VNC anterior
/opt/TurboVNC/bin/vncserver -kill :1 > /dev/null 2>&1 || true
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Inicia servidor VNC com XFCE
/opt/TurboVNC/bin/vncserver :1 -geometry 1920x1080 -depth 24 -fg &

# Espera o servidor VNC subir
sleep 3

# Inicia noVNC apontando para o VNC
/opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 6080 &

echo "✅ Acesse no navegador: http://localhost:6080 (senha: rosvnc)"

# Mantém o container rodando
tail -f /dev/null
