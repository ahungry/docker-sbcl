FROM archlinux/base:latest

RUN yes | pacman -Syu
RUN yes | pacman -S sbcl

WORKDIR "/root"
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp
RUN sbcl --non-interactive \
    --load quicklisp.lisp \
    --eval '(quicklisp-quickstart:install)'
COPY sbclrc .sbclrc

CMD ["/bin/sbcl", "--version"]
#ENTRYPOINT

#RUN tazpkg get-install gcc
#RUN tazpkg get-install mercurial
#RUN hg clone http://hg.code.sf.net/p/clisp/clisp clisp-clisp

#RUN apk update
#RUN apk add gcc mercurial
#RUN hg clone http://hg.code.sf.net/p/clisp/clisp clisp-clisp
