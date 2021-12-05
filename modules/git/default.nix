{ pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Sylvie Poulsen";
    userEmail = "git@poulsen.xyz";
    signing = {
      key = "AEB12283C38DBBE5";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      commit = {
        #gpgsign = true;
      };
    };
  };
}
