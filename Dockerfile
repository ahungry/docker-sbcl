FROM archlinux/base:latest

RUN yes | pacman -Syu
RUN yes | pacman -S sbcl
RUN yes dummy | useradd dummy
RUN mkdir -p /home/dummy
RUN chown -R dummy:dummy /home/dummy

WORKDIR /root
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp
RUN sbcl --non-interactive \
    --load quicklisp.lisp \
    --eval '(quicklisp-quickstart:install)'
COPY sbclrc .sbclrc

WORKDIR /app
RUN chown -R dummy:dummy /app
RUN su -c 'curl -O https://beta.quicklisp.org/quicklisp.lisp' dummy
RUN su -c "sbcl --non-interactive --load quicklisp.lisp --eval '(quicklisp-quickstart:install)'" dummy

COPY sbclrc /home/dummy/.sbclrc

# Preload two pretty heavy libs
RUN sbcl --non-interactive --eval '(ql:quickload :caveman2)'
RUN sbcl --non-interactive --eval '(ql:quickload :ironclad)'
RUN su -c "sbcl --non-interactive --eval '(ql:quickload :caveman2)'" dummy
RUN su -c "sbcl --non-interactive --eval '(ql:quickload :ironclad)'" dummy

CMD ["/bin/sbcl"]
