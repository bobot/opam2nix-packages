world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      cmdliner = opamSelection.cmdliner;
      crunch = opamSelection.crunch;
      dolog = opamSelection.dolog;
      mirage = opamSelection.mirage;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind or null;
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
  name = "mirage-seal-0.3.1";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "mirage-seal";
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
    sha256 = "15zl63zpajrm51n0xcgichpkn43cnk8hqyxzbrd3743yki2qas0j";
    url = "https://github.com/mirage/mirage-seal/archive/0.3.1.tar.gz";
  };
}

