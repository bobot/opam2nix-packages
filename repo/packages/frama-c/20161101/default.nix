world:
let
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      alt-ergo = opamSelection.alt-ergo;
      altgr-ergo = opamSelection.altgr-ergo or null;
      conf-gnomecanvas = opamSelection.conf-gnomecanvas;
      conf-gtksourceview = opamSelection.conf-gtksourceview;
      frama-c-base = opamSelection.frama-c-base;
      lablgtk = opamSelection.lablgtk;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      zarith = opamSelection.zarith;
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
  name = "frama-c-20161101";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "frama-c";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  propagatedBuildInputs = inputs;
  unpackPhase = "true";
}

