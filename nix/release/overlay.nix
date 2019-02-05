self: super: with super; {
	opam2nix = let
		src = fetchFromGitHub {
			"owner" = "timbertson";
			"repo" = "opam2nix-packages";
			"sha256" = "02pkk1p14w5fw5ic0zwyc0zcqa393n16jizsqy9hcf5cp2wr41ad";
			"rev" = "0f70fa09849349af24a5c3980bed7188b594aa41";
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
