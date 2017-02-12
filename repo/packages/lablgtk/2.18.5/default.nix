world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.expat or null) (pkgs.gtk or null) (pkgs."gtk+2.0-dev" or null)
        (pkgs.gtk2-devel or null) (pkgs.libexpat1-dev or null)
        (pkgs."libgtk2.0-dev" or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      conf-glade = opamSelection.conf-glade or null;
      conf-gnomecanvas = opamSelection.conf-gnomecanvas or null;
      conf-gtksourceview = opamSelection.conf-gtksourceview or null;
      lablgl = opamSelection.lablgl or null;
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
  name = "lablgtk-2.18.5";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = ./files;
    name = "lablgtk";
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
    sha256 = "0cyj6sfdvzx8hw7553lhgwc0krlgvlza0ph3dk9gsxy047dm3wib";
    url = "https://forge.ocamlcore.org/frs/download.php/1627/lablgtk-2.18.5.tar.gz";
  };
}

