self: super: with super; {
	opam2nix = let
		src = fetchFromGitHub {
			"owner" = "timbertson";
			"repo" = "opam2nix-packages";
			"sha256" = "0a6a4rsxm5hba2zdnz081r01vrjcm2j90r02j21wrs4l32vdfrm9";
			"rev" = "31a7d9cc57198d26932000788fefff74cb172611";
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
;
}
