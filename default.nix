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
      sha256 = "0d78pqc6h7mc1sfm4cwknr1jph4qlg0rkygfgdhkj45nsq1rm3b1";
    };

    buildInputs = [
      pythonPackages.six
      pythonPackages.Mako
      pythonPackages.pyscss
      pythonPackages.requests
      pythonPackages.markupsafe
    ];

    doCheck = false; # some files required by the test seem to be missing
  };

  rstcheck = pythonPackages.buildPythonPackage rec {
    name = "rstcheck-3.1";

    src = pkgs.fetchFromGitHub{
      owner = "myint";
      repo = "rstcheck";
      rev = "v3.2";
      sha256 = "1rgcmaps703lxprgf3wmfwg2q54hv75jf7fcn284ckfa37csp4rs";
    };

    buildInputs = with pythonPackages; [ docutils ];

    doCheck = false; # some files required by the test seem to be missing
  };


in rec {
  pyEnv = stdenv.mkDerivation {
    name = "lectures-1.0.0";
    buildEnv = with pythonPackages; [
      pytz
      Mako
      Babel
    ];
    buildInputs = with pythonPackages; [
      ipdb
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
