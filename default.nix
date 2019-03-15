{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  pythonPackages = pkgs.python3Packages;


  babel = pythonPackages.buildPythonPackage rec {
    name = "babel";

    src = pkgs.fetchFromGitHub {
      owner = "python-babel";
      repo = "babel";
      rev = "v2.6.0";
      sha256 = "1j18gfrln06bz58rysy18myqdb7np7ikagww4qv4qsjvmd0rjnpv";
    };

    buildInputs = [
      pythonPackages.pytz
    ];

    doCheck = false; # some files required by the test seem to be missing
  };

  mysphinx = pythonPackages.buildPythonPackage rec {
    name = "sphinx";

    src = pkgs.fetchFromGitHub {
      owner = "sphinx-doc";
      repo = "sphinx";
      rev = "v1.8.1";
      sha256 = "16gn0rqpsnrbrggvdy40krz2xs9fdnys87jqmdz45zdv8y3lkc7p";
    };

    buildInputs = [
      babel
      pythonPackages.six
      pythonPackages.pytz
      pythonPackages.pygments
      pythonPackages.jinja2
      pythonPackages.alabaster
      pythonPackages.imagesize
      pythonPackages.requests
      pythonPackages.snowballstemmer
      pythonPackages.sphinxcontrib-websupport
    ];

    doCheck = false; # some files required by the test seem to be missing
  };

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
    buildInputs = with pythonPackages; [
      ipdb
      Mako
      pyscss
      mysphinx
      ipython
      zzzeeksphinx
      sphinx_links
      docutils
      rstcheck
    ];
  };
}
