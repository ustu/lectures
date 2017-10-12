{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  pythonPackages = pkgs.python3Packages;

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

  zzzeeksphinx = pythonPackages.buildPythonPackage rec {
    name = "zzzeeksphinx";

    src = pkgs.fetchFromBitbucket {
      owner = "uralbash";
      repo = "zzzeeksphinx";
      rev = "master";
      sha256 = "1zrzivdq6ndm5s63g6jk301yna87812pzcr3r54d5hfn9ykqci5y";
    };

    buildInputs = [
      pythonPackages.Mako
      pythonPackages.pyscss
      pythonPackages.markupsafe
      pythonPackages.six
    ];

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
      Mako
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
