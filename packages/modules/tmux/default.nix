{ pkgs, ... }: let

  # Rebind leader to Ctrl-a
  leader = "a";
  # enable 256 color term.
  term = "screen-256color";

  tmuxConf = ''
    # bind 'C-a C-a' to type 'C-a'
    bind C-a send-prefix

    # Bind <<M-[hjkl]>> to switch panes w/o needing leader (-n flag).
    bind -n M-h select-pane -L
    bind -n M-l select-pane -R
    bind -n M-k select-pane -U
    bind -n M-j select-pane -D

    # Bind window splitting to the same as I use in emacs.
    # New panes open in same directory w/ the -c flag.
    bind / split-window -h -c '#{pane_current_path}' # horizontal split
    bind - split-window -v -c '#{pane_current_path}' # Vertical split

    # When creating new window, keep same directory
    bind c new-window -c '#{pane_current_path}'

    # Cycle windows (-r flag to not have to hit leader each time).
    bind -r C-h select-window -t :-
    bind -r C-l select-window -t :+

    # Reload ~/.tmux.conf with <<Leader - R>>
    bind r source-file ~/.tmux.conf

    ##### STATUS LINE #####
    # set-window-option -g status-left " #S "
    # set-window-option -g status-left-fg black
    # set-window-option -g status-left-bg "#B48EAD"

    set -g status-right-length 150
    # set-window-option -g status-right " #S #I:#P | continuum: #{continuum_status} | %H:%M | %d-%b-%y "
    # set-window-option -g status-right-fg black
    # set-window-option -g status-right-bg white

    set-window-option -g window-status-format " #I: #W "
    set-window-option -g window-status-current-format " #I: #W "

    #set-window-option -g window-status-current-fg "#b48ead"
    #set-window-option -g window-status-current-bg black

    ##### PLUGINS #####

    # List of plugins

    # Show continuum status in status bar
    # set -g status-right 'Continuum status: #{continuum_status}'
  '';
in {
  programs.tmux = {
    enable = true;

    shortcut = leader;
    terminal = term;

    extraConfig = tmuxConf;

    plugins = with pkgs.tmuxPlugins; [
      cpu
      ctrlw
      tmux-fzf
      nord
      sensible
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
  };
}
