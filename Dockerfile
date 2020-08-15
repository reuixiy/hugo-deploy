FROM archlinux

RUN pacman -Syu --noconfirm hugo git openssh

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
