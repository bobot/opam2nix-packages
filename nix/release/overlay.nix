self: super: with super; {
	opam2nix = let
		src = fetchFromGitHub {
			"owner" = "timbertson";
			"repo" = "opam2nix-packages";
			"sha256" = "0rgqvi3gdy8mllg1b1q0ydkpfh8p2n6q4bq42y02cba6svs759f6";
			"rev" = "b2990e83084af3ee34a64873ccf708fb470417ba";
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
