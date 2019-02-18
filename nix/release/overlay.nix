self: super: with super; {
	opam2nix = let
		src = fetchFromGitHub {
			"owner" = "timbertson";
			"repo" = "opam2nix-packages";
			"sha256" = "0m15l5jdi1ww7pipi38xxk2sqn54nx9mzx8kzia7ixwl8yva80rn";
			"rev" = "83043673c9cde31c7029950f8bb5a3ad3ab0406b";
		};
		opam2nixSrc = fetchFromGitHub {
			"owner" = "bobot";
			"repo" = "opam2nix";
			"sha256" = "07xvim1yq55pc16kp2v191larwy5hv1k0725i8f5nxqb2kayjf51";
			"rev" = "version-0.3.2";
		};
		opam2nixBin = callPackage "${opam2nixSrc}/nix" {};
	in
	callPackage "${src}/nix" { inherit opam2nixBin; }
;
}
