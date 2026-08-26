{
pkgs,
yaziPkgs,
...
}:
{
  environment.systemPackages = with pkgs; [
    # cloud
    awscli2
    ssm-session-manager-plugin
    terraform
    azure-cli
    argocd
    k9s
    kubectl

    util-linux # NOTE: will this mess with our host?

    yaziPkgs.yazi

    # nixGLPkgs.default

    docker-credential-helpers

    firefox-bin

    nix-fast-build
    nix-output-monitor

    ghostty-bin

    libreoffice-bin

    gimp2

    # libsecret
  ];
}
