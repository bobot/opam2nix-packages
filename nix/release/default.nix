{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
		src = fetchFromGitHub {
			"owner" = "bobot";
			"repo" = "opam2nix-packages";
			"sha256" = "1zhl8rf911163h7c7acynpcawv3kgvz83gxcscycvq948wx0zccm";
			"rev" = "0e309bafbbea78a3f9636fe2a681c1d1e46c67da";
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

