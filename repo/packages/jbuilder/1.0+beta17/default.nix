world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      js_of_ocaml-compiler = opamSelection.js_of_ocaml-compiler or null;
      menhir = opamSelection.menhir or null;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree or null;
      ocamlfind = opamSelection.ocamlfind;
      odoc = opamSelection.odoc or null;
      ppx_driver = opamSelection.ppx_driver or null;
      reason = opamSelection.reason or null;
      utop = opamSelection.utop or null;
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
  name = "jbuilder-1.0+beta17";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "jbuilder";
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
    sha256 = "1k0v15flcbw19k61v5zggq9cz4y4ymja3hiaq7v0fv5p7j316g9q";
    url = "https://github.com/ocaml/dune/releases/download/1.0+beta17/jbuilder-1.0.beta17.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}
