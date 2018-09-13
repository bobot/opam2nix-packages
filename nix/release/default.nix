{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
		src = fetchFromGitHub {
			"owner" = "bobot";
			"repo" = "opam2nix-packages";
			"sha256" = "0l36lj7h216jja5pfxz3pnvw1yk2sfwsdcgm80x54zz4liaj1cff";
			"rev" = "3a2d03b0d97047c0f0ca59b2424176358dbaebad";
		};
		opam2nixSrc = fetchFromGitHub {
			"owner" = "timbertson";
			"repo" = "opam2nix";
			"sha256" = "07xvim1yq55pc16kp2v191larwy5hv1k0725i8f5nxqb2kayjf51";
			"rev" = "version-0.3.2";
		};
		opam2nixBin = callPackage "${opam2nixSrc}/nix" {};
	in
	callPackage "${src}/nix" { inherit opam2nixBin; }

