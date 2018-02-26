-- Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \ncurl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle

-- ALE
git clone https://github.com/w0rp/ale.git

-- Surround
git clone git://github.com/tpope/vim-surround.git 

-- FZF?
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

-- ack
?    a quick summary of these keys, repeat to close
o    to open (same as Enter)
O    to open and close the quickfix window
go   to preview file, open but maintain focus on ack.vim results
t    to open in new tab
T    to open in new tab without moving to it
h    to open in horizontal split
H    to open in horizontal split, keeping focus on the results
v    to open in vertical split
gv   to open in vertical split, keeping focus on the results
q    to close the quickfix window

git clone https://github.com/mileszs/ack.vim.git

-- CtrlP
https://github.com/kien/ctrlp.vim
git clone https://github.com/kien/ctrlp.vim.git

-- Indent guides
git clone git://github.com/nathanaelkane/vim-indent-guides.git

-- Nerd tree
git clone https://github.com/scrooloose/nerdtree.git

-- Airline
git clone https://github.com/bling/vim-airline

-- JS
git clone https://github.com/pangloss/vim-javascript.git

-- Tagbar
git clone https://github.com/majutsushi/tagbar

-- Lets see..
https://github.com/vim-ctrlspace/vim-ctrlspace
https://vimawesome.com/plugin/vim-test-all-too-well
