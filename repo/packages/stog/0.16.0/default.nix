world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      higlo = opamSelection.higlo;
      js_of_ocaml = opamSelection.js_of_ocaml or null;
      lwt = opamSelection.lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      ocamlnet = opamSelection.ocamlnet;
      ocf = opamSelection.ocf;
      ojs-base = opamSelection.ojs-base or null;
      ppx_blob = opamSelection.ppx_blob;
      sha = opamSelection.sha or null;
      websocket = opamSelection.websocket or null;
      xmldiff = opamSelection.xmldiff or null;
      xtmpl = opamSelection.xtmpl;
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
  name = "stog-0.16.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = ./files;
    name = "stog";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  prePatch = "cp -r ${./files}/* ./";
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "06h8d2r806zrhpasx08n4p9z6srimyj1bi3flhzlil2zfm0kqim9";
    url = "http://zoggy.github.com/stog/stog-0.16.0.tar.gz";
  };
}

