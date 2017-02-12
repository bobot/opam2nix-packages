world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      base-bytes = opamSelection.base-bytes;
      base-no-ppx = opamSelection.base-no-ppx or null;
      base-threads = opamSelection.base-threads or null;
      base-unix = opamSelection.base-unix or null;
      camlp4 = opamSelection.camlp4 or null;
      conf-libev = opamSelection.conf-libev or null;
      lablgtk = opamSelection.lablgtk or null;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
      ppx_tools = opamSelection.ppx_tools or null;
      react = opamSelection.react or null;
      result = opamSelection.result;
      ssl = opamSelection.ssl or null;
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
  name = "lwt-2.6.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "lwt";
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
    sha256 = "1gbw0g8a5a4b16diqrmlhc8ilnikrm4w3jjm1zq310maqg8z0zxz";
    url = "https://github.com/ocsigen/lwt/archive/2.6.0.tar.gz";
  };
}

