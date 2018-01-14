world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      base-unix = opamSelection.base-unix;
      conduit-lwt = opamSelection.conduit-lwt;
      ipaddr = opamSelection.ipaddr;
      jbuilder = opamSelection.jbuilder;
      launchd = opamSelection.launchd or null;
      lwt = opamSelection.lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      ssl = opamSelection.ssl or null;
      tls = opamSelection.tls or null;
      uri = opamSelection.uri;
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
  name = "conduit-lwt-unix-1.0.3";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "conduit-lwt-unix";
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
    sha256 = "1pdb718vimghqiqmms9wdsgs5xaghixjcdwij7m9ia32abplnvsb";
    url = "https://github.com/mirage/ocaml-conduit/releases/download/v1.0.3/conduit-1.0.3.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

