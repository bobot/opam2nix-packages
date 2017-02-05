world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bisect = opamSelection.bisect or null;
      bisect_ppx = opamSelection.bisect_ppx or null;
      ezjsonm = opamSelection.ezjsonm;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
    };
    opamSelection = world.opamSelection;
    pkgs = world.pkgs;
in
pkgs.stdenv.mkDerivation 
{
  buildInputs = inputs;
  buildPhase = "${opam2nix}/bin/opam2nix invoke build";
  configurePhase = "true";
  installPhase = "${opam2nix}/bin/opam2nix invoke install";
  name = "ocveralls-0.3.4";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ocveralls";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "1gmg8g7hzd0mkk8x0pkhvzwpzi9gmc7rybkvffap3p6xis4z6hnj";
    url = "https://github.com/sagotch/ocveralls/archive/3.3.4.tar.gz";
  };
}

