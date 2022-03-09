{ options, ... }: let

   # General syntax:
   # (map! :leader
   #    (:prefix-map ("w" . "window") ;; to display 'window' in the minibuffer
   #     (:prefix ("/" . "journal")   ;; sub menu to 'journal'
   #      :desc "New journal entry" "j" #'org-journal-new-entry
   #      :desc "Search journal entry" "s" #'org-journal-search)))
   keybindings = ''
   (map! :leader

      ;; SPC-SPC to open M-x
      :desc "Command" "SPC" #'counsel-M-x
      ;; SPC-: to find a file in the current project
      :desc "Find file in current project" ":" #'projectile-find-file

      ;; SPC-p-v to open magit
      (:prefix ("p" . "project")
        :desc "open layout" "l" #'projectile-switch-project
        :desc "magit" "v" #'magit)

      ;; Change window split keybindings
      (:prefix ("w" . "window")
        :desc "Vertical split" "/" #'(lambda () (interactive) (sylvie/gr-wrapper #'evil-window-vsplit))
        :desc "Horizontal split" "-" #'(lambda () (interactive) (sylvie/gr-wrapper #'evil-window-split))
        :desc "Horizontal split" "0" #'(lambda () (interactive) (sylvie/gr-wrapper #'evil-window-split))

        :desc "Move to right window" "l" #'(lambda () (interactive) (sylvie/gr-wrapper #'windmove-right))
        :desc "Move to window above" "k" #'(lambda () (interactive) (sylvie/gr-wrapper #'windmove-up))
        :desc "Move to window below" "j" #'(lambda () (interactive) (sylvie/gr-wrapper #'windmove-down))
        :desc "Move to left window" "h" #'(lambda () (interactive) (sylvie/gr-wrapper #'windmove-left))

        :desc "Decrease window height" "C--" #'evil-window-decrease-height)

      ;; Add layout keybindings
      (:prefix ("l" . "layout")
        (:prefix ("g" . "golden-ratio")
          :desc "Resize with golden-ratio" "g" #'golden-ratio-mode
          :desc "Toggle golden-ratio-mode" "t" #'golden-ratio-mode)

        :desc "Open project in new workspace" "p" #'projectile-switch-project
        :desc "Close workspace" "x" #'+workspace/delete

        :desc "Rename workspace" "," #'+workspace/rename

        :desc "Display workspaces" "l" #'+workspace/display
        :desc "Switch to workspace 1" "1" #'+workspace/switch-to-0
        :desc "Switch to workspace 2" "2" #'+workspace/switch-to-1
        :desc "Switch to workspace 3" "3" #'+workspace/switch-to-2
        :desc "Switch to workspace 4" "4" #'+workspace/switch-to-4
        :desc "Switch to workspace 5" "5" #'+workspace/switch-to-4
        :desc "Switch to workspace 6" "6" #'+workspace/switch-to-5
        :desc "Switch to workspace 7" "7" #'+workspace/switch-to-6
        :desc "Switch to workspace 8" "8" #'+workspace/switch-to-7
        :desc "Switch to workspace 9" "9" #'+workspace/switch-to-8
        :desc "Switch to workspace 10" "0" #'+workspace/switch-to-9))
   '';

   config = ''
    ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

    ;; Place your private configuration here! Remember, you do not need to run 'doom
    ;; sync' after modifying this file!
    (require 'golden-ratio)
    (golden-ratio-mode 1)

    (defun sylvie/gr-wrapper (fun)
      (interactive)
      (funcall fun)
      (golden-ratio))

    ;; Some functionality uses this to identify you, e.g. GPG configuration, email
    ;; clients, file templates and snippets.
    (setq user-full-name "Sylvie Poulsen"
          user-mail-address "sylvie@doublespell.com")

    ;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
    ;; are the three important ones:
    ;;
    ;; + `doom-font'
    ;; + `doom-variable-pitch-font'
    ;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
    ;;   presentations or streaming.
    ;;
    ;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
    ;; font string. You generally only need these two:
    (setq doom-font (font-spec :family "Cascadia Code" :size 16 :weight 'semi-light)
          doom-variable-pitch-font (font-spec :family "Cascadia Code" :size 18))

    ;; There are two ways to load a theme. Both assume the theme is installed and
    ;; available. You can either set `doom-theme' or manually load a theme with the
    ;; `load-theme' function. This is the default:
    ;;(setq doom-theme 'doom-one)
    (setq doom-theme 'doom-nord)

    ;; If you use `org' and don't want your org files in the default location below,
    ;; change `org-directory'. It must be set before org loads!
    (setq org-directory "~/org/")

    ;; This determines the style of line numbers in effect. If set to `nil', line
    ;; numbers are disabled. For relative line numbers, set this to `relative'.
    (setq display-line-numbers-type t)


    ;; Here are some additional functions/macros that could help you configure Doom:
    ;;
    ;; - `load!' for loading external *.el files relative to this one
    ;; - `use-package!' for configuring packages
    ;; - `after!' for running code after a package has loaded
    ;; - `add-load-path!' for adding directories to the `load-path', relative to
    ;;   this file. Emacs searches the `load-path' when you load packages with
    ;;   `require' or `use-package'.
    ;; - `map!' for binding new keys
    ;;
    ;; To get information about any of these functions/macros, move the cursor over
    ;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
    ;; This will open documentation for it, including demos of how they are used.
    ;;
    ;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
    ;; they are implemented.

    ${keybindings}
  '';
in {
    cfg = config;
}
