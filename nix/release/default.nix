{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
		src = fetchFromGitHub {
			"owner" = "bobot";
			"repo" = "opam2nix-packages";
			"sha256" = "02pkk1p14w5fw5ic0zwyc0zcqa393n16jizsqy9hcf5cp2wr41ad";
			"rev" = "0f70fa09849349af24a5c3980bed7188b594aa41";
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

