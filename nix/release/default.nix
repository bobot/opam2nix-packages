{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
		src = fetchFromGitHub {
			"owner" = "bobot";
			"repo" = "opam2nix-packages";
			"sha256" = "0978xkmd0iz15hbz8360kji07lnqbw0iyxfnl3pwqmijwwiaw97r";
			"rev" = "65bfc9baa62e262fd37e4fa65cbe91f5bac6ed83";
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

