{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  pythonPackages = pkgs.python36Packages;

  sphinx_links = pythonPackages.buildPythonPackage rec {
    name = "sphinx_links";

    src = pkgs.fetchFromGitHub {
      owner = "uralbash";
      repo = "sphinx-links";
      rev = "master";
      sha256 = "15g7024ijqaz3ggvinlwcqwwycn2gjgwfk72zah5432aa9a6bj8l";
    };

    doCheck = false; # some files required by the test seem to be missing
  };

  markupSafe = pythonPackages.buildPythonPackage rec {
    name = "MarkupSafe";

    src = pkgs.fetchFromGitHub {
      owner = "pallets";
      repo = "markupsafe";
      rev = "master";
      sha256 = "10wfpivc5d28jan4xgzi4j6f3lnyy2bzvi35yv75ml7xs3f0hc6w";
    };

    doCheck = false; # some files required by the test seem to be missing
  };

  pyscss = pythonPackages.buildPythonPackage rec {
    name = "pyscss";

    src = pkgs.fetchFromGitHub {
      owner = "Kronuz";
      repo = "pyScss";
      rev = "master";
      sha256 = "1scwlw2zpbjgkd2xsnwygj5fx157xv2qddpzb8rj9svrxyj0nqw4";
    };

    buildInputs = with pythonPackages; [ six ];

    doCheck = false; # some files required by the test seem to be missing
  };

  mako = pythonPackages.buildPythonPackage rec {
    name = "mako";

    src = pkgs.fetchurl {
      url = mirror://pypi/P/Paste/Mako-1.0.4.tar.gz;
      sha256 = "0nchpw6akfcsg8w6irjlx0gyzadc123hv4g47sijgnqd9nz9vngy";
    };

    buildInputs = [ markupSafe ];

    doCheck = false; # some files required by the test seem to be missing
  };

  zzzeeksphinx = pythonPackages.buildPythonPackage rec {
    name = "zzzeeksphinx";

    src = pkgs.fetchFromBitbucket {
      owner = "uralbash";
      repo = "zzzeeksphinx";
      rev = "master";
      sha256 = "1zrzivdq6ndm5s63g6jk301yna87812pzcr3r54d5hfn9ykqci5y";
    };

    buildInputs = [ mako pyscss markupSafe pythonPackages.six ];

    doCheck = false; # some files required by the test seem to be missing
  };

  rstcheck = pythonPackages.buildPythonPackage rec {
    name = "rstcheck-3.1";

    src = pkgs.fetchFromGitHub{
      owner = "myint";
      repo = "rstcheck";
      rev = "master";
      sha256 = "1wmjmmbg43vbkimahlj92g2bzzazwavrwg9f284zpa2npaxrlpq5";
    };

    buildInputs = with pythonPackages; [ docutils ];

    doCheck = false; # some files required by the test seem to be missing
  };

in rec {
  pyEnv = stdenv.mkDerivation {
    name = "lectures-1.0.0";
    buildInputs = with pythonPackages; [
      mako
      pyscss
      sphinx
      ipython
      zzzeeksphinx
      sphinx_links
      docutils
      rstcheck
    ];
  };
}
