{
  nixpkgs.config.packageOverrides = pkgs: {
    khard =
      let
        python3 = pkgs.python3.override {
          packageOverrides = _: prev: {
            sphinx-argparse = prev.sphinx-argparse.overridePythonAttrs (old: {
              postPatch = (old.postPatch or "") + ''
                substituteInPlace sphinxarg/ext.py \
                  --replace-fail \
                    'from sphinx.ext.autodoc import mock' \
                    'from sphinx.ext.autodoc.mock import mock'
              '';
            });
          };
        };
      in
      pkgs.khard.override { inherit python3; };
    iamb = pkgs.iamb.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        sed -i '1i #![recursion_limit = "256"]' src/main.rs
      '';
    });
  };
}
