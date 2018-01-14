world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      alcotest-lwt = opamSelection.alcotest-lwt or null;
      astring = opamSelection.astring;
      capnp = opamSelection.capnp;
      capnp-rpc-lwt = opamSelection.capnp-rpc-lwt;
      fmt = opamSelection.fmt;
      io-page-unix = opamSelection.io-page-unix or null;
      jbuilder = opamSelection.jbuilder;
      logs = opamSelection.logs;
      mirage-dns = opamSelection.mirage-dns;
      mirage-stack-lwt = opamSelection.mirage-stack-lwt;
      mirage-vnetif = opamSelection.mirage-vnetif or null;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      tcpip = opamSelection.tcpip or null;
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
  name = "capnp-rpc-mirage-0.3.1";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "capnp-rpc-mirage";
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
    sha256 = "0bs0ld9cm4hals5rqrgalmkj6aqbsrpa1nki0cmzfi9x9frgllc1";
    url = "https://github.com/mirage/capnp-rpc/releases/download/0.3.1/capnp-rpc-0.3.1.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

