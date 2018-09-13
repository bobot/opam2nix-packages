self: super: with super; {
	opam2nix = let
		src = fetchFromGitHub {
			"owner" = "timbertson";
			"repo" = "opam2nix-packages";
			"sha256" = "0q59f7s0j5ywhhls96gsiy2khnr885672k9gjsqnfj0d3phd3pxy";
			"rev" = "4e8a8d7b0169bca7f194c20781537ced686b49c7";
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
;
}
