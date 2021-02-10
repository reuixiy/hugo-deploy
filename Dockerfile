# Hot fix for issue #6
FROM archlinux/archlinux:base-20210203.0.15035

# FROM archlinux

RUN pacman -Syu --noconfirm hugo git openssh

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
