{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-css-color
      nord-vim
      gitgutter
      syntastic
    ];

    extraConfig = ''
      set encoding=utf-8 

      "Line numbers.
      set number

      "modeline = true

      "Convert tabs to spaces.
      set tabstop=2
      set shiftwidth=2
      set expandtab

      set mouse="a"

      set smartcase
      set ignorecase

      "Colorscheme.
      colorscheme nord

      set softtabstop=2
      set smarttab

      "Syntax highlighting and autoindenting based on filetype.
      filetype indent plugin on
      syntax on
      
      set laststatus=2

      "Highlight search results:
      set hlsearch
      "\q to turn off highlight:
      nmap \q :nohlsearch<CR>
      "Highlight while typing:
      set incsearch

       
      "Folding blocks of code (indent & manual):
      augroup folds
          au BufReadPre * setlocal foldmethod=indent
          au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
      augroup END
      
      "Autoreload when vimrc changes:
      augroup myvimrc
          au!
          au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
      augroup END
      
      "Keybingdings
      nmap \t :tabnew
      nmap \w :TagbarToggle<CR>
      nmap \e :NERDTreeToggle<CR>
      nmap \s :SyntasticCheck<CR>
      nmap ; :CtrlPBuffer<CR>
      nmap \d :Dash<CR>
      "For quickly pulling up the buffer list and changing buffers.
      nmap <F5> :buffers<CR>:buffer<Space>
      nmap <C-a> <Home>
      nmap <C-e> <End>
    '';
  };
}
