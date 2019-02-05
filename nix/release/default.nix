{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
		src = fetchFromGitHub {
			"owner" = "bobot";
			"repo" = "opam2nix-packages";
			"sha256" = "0y3x4w2wgwsamzvxhrh1371zs5xhd0cyihvv1z306ni7dd3m864c";
			"rev" = "b52677e1975c59c436e1edff9d77c89d98ebf547";
		};
		opam2nixSrc = fetchFromGitHub {
			"owner" = "bobot";
			"repo" = "opam2nix";
			"sha256" = "0vgmmzbk0hm7yvqfa7sfmiy61ac12nzfsmvgn6sadmhpg2vbclm3";
			"rev" = "8cd5938734c8343fd9871fb22e2fadd69b7e2a5c";
		};
		opam2nixBin = callPackage "${opam2nixSrc}/nix" {};
	in
	callPackage "${src}/nix" { inherit opam2nixBin; }

