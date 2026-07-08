#!/bin/bash
set -euo pipefail

echo "=== Updating apt ==="
sudo apt-get update -qq

echo "=== Installing core tools via apt ==="
sudo apt-get install -y -qq \
  neovim fzf zoxide direnv bat ripgrep \
  nodejs npm unzip curl wget build-essential

echo "=== Installing eza ==="
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update -qq
sudo apt-get install -y -qq eza

echo "=== Installing lazygit ==="
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin/lazygit
rm /tmp/lazygit /tmp/lazygit.tar.gz

echo "=== Installing oh-my-posh ==="
curl -s https://ohmyposh.dev/install.sh | bash -s

echo "=== Installing Oh My Fish ==="
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish --command 'source - --noninteractive --yes'

echo "=== Installing Fisher (fish plugin manager) ==="
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

echo "=== Installing fzf.fish plugin ==="
fish -c 'fisher install patrickf1/fzf.fish'

echo "=== Installing TPM (tmux plugin manager) ==="
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || echo "TPM already installed"

echo "=== Setting fish as default shell ==="
chsh -s /usr/bin/fish

echo ""
echo "=== Done! ==="
echo "NOTE: On Ubuntu, 'bat' is installed as 'batcat'. A symlink will be created."
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
echo "Created symlink: ~/.local/bin/bat -> /usr/bin/batcat"
echo ""
echo "Next steps:"
echo "  1. Close and reopen your terminal (or run 'fish')"
echo "  2. In tmux, press Ctrl-a then I (capital i) to install tmux plugins"
echo "  3. Open nvim - LazyVim will auto-install plugins on first launch"
echo "  4. Install a Nerd Font on WINDOWS (e.g., JetBrainsMono Nerd Font) for icons to render"
