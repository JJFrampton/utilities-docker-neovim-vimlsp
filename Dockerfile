FROM ubuntu

RUN apt-get -y update
RUN apt-get -y install wget curl git

RUN curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -o nvim-linux64.tar.gz
RUN tar xzvf nvim-linux64.tar.gz
RUN chmod +x nvim-linux64/bin/nvim
RUN chown root:root nvim-linux64/bin/nvim
RUN mv nvim-linux64/bin/nvim /usr/bin

RUN useradd -ms /bin/bash jframpton
RUN mkdir -p /home/jframpton/.config/nvim/plugged
USER jframpton
WORKDIR /home/jframpton
RUN chown -R jframpton:jframpton /home/jframpton/

COPY init.vim .config/nvim/init.vim

RUN echo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
