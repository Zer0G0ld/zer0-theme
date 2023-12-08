# zer0-theme

sh -c 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

### configuração do neovim/nvim 

<p>Arquivo init.lua</p>
<p>~/.config/nvim/init.lua
</p>

### Possíveis erros e correções

#### Error

```Error

Error detected while processing /data/data/com.termux/
files/home/.config/nvim/init.lua:
E5113: Error while calling lua chunk: /data/data/com.termux/files/home/.config/nvim/init.lua:34: module 'cmp' not found:
no field package.preload['cmp']                       no file './cmp.lua'
no file '/data/data/com.termux/files/usr/share/luajit-2.1.0-beta3/cmp.lua'
no file '/usr/local/share/lua/5.1/cmp.lua'            no file '/usr/local/share/lua/5.1/cmp/init.lua'
no file '/data/data/com.termux/files/usr/share/lua/5.1/cmp.lua'
no file '/data/data/com.termux/files/usr/share
/lua/5.1/cmp/init.lua'
no file './cmp.so'
no file '/usr/local/lib/lua/5.1/cmp.so'
no file '/data/data/com.termux/files/usr/lib/lua/5.1/cmp.so'
no file '/usr/local/lib/lua/5.1/loadall.so'   stack traceback:
[C]: in function 'require'                            /data/data/com.termux/files/home/.config/nvim/
init.lua:34: in main chunk
Press ENTER or type command to continue

```

#### Correção 

```Correção

cd ~/.config/nvim
git clone https://github.com/hrsh7th/nvim-cmp.git pack/packer/start/nvim-cmp

```

> Não esqueça de dentro do arquivo `init.lua` você deve sair do modo inserção `ESC` logo depois disso digite `:PackerInstall`
