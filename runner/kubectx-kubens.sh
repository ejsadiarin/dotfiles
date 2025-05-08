#!/usr/bin/env sh

if [ -f "/usr/local/bin/kubectx" ] || [ -f "/usr/local/bin/kubens" ]; then
    sudo rm -rf /opt/kubectx
    sudo rm -f /usr/local/bin/kubectx
    sudo rm -f /usr/local/bin/kubens
    # sudo rm -f $HOME/dotfiles/config/zsh/kubectx-completion.zsh
    # sudo rm -f $HOME/dotfiles/config/zsh/kubens-completion.zsh
fi

sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# if [ ! -f "$HOME/dotfiles/config/zsh/kubectx-completion.zsh" ] && [ ! -f "$HOME/dotfiles/config/zsh/kubens-completion.zsh" ]; then
#     # sudo cp /opt/kubectx/completion/_kubectx.zsh $HOME/dotfiles/config/zsh/kubectx-completion.zsh
#     # sudo cp /opt/kubectx/completion/_kubens.zsh $HOME/dotfiles/config/zsh/kubens-completion.zsh
#     echo
# fi
