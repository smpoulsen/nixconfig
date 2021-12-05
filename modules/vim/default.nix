{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    settings = {
      # Line numbers.
      number = true;

      # modeline = true;

      # Convert tabs to spaces.
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;

      mouse = "a";

      smartcase = true;
      ignorecase = true;
    };

    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-css-color
      nord-vim
      gitgutter
      syntastic
    ];

    extraConfig = ''
      set encoding=utf-8 

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
## 
## "
## 
## "For vim-airline to show up:
## set laststatus=2
## "vim-airline fonts
## let g:airline_powerline_fonts = 1
## let g:airline#extensions#tabline#enabled = 1
## 
## 
## 

