world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      astring = opamSelection.astring;
      base-bytes = opamSelection.base-bytes;
      cmdliner = opamSelection.cmdliner;
      cstruct = opamSelection.cstruct;
      ezjsonm = opamSelection.ezjsonm or null;
      fmt = opamSelection.fmt;
      io-page-unix = opamSelection.io-page-unix;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      mirage-block = opamSelection.mirage-block;
      mirage-block-ramdisk = opamSelection.mirage-block-ramdisk or null;
      mirage-block-unix = opamSelection.mirage-block-unix;
      mirage-types-lwt = opamSelection.mirage-types-lwt;
      nbd = opamSelection.nbd or null;
      oasis = opamSelection.oasis;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      ounit = opamSelection.ounit or null;
      ppx_deriving = opamSelection.ppx_deriving;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      ppx_tools = opamSelection.ppx_tools;
      ppx_type_conv = opamSelection.ppx_type_conv;
      result = opamSelection.result;
      sexplib = opamSelection.sexplib;
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
  name = "qcow-format-0.4.1";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "qcow-format";
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
    sha256 = "02w62dzyfnxmab2yzb178kwwqj77xkypxggc0gazlamfjsg12phc";
    url = "https://github.com/mirage/ocaml-qcow/archive/v0.4.1.tar.gz";
  };
}

