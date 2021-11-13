#!/bin/sh

URL='https://raw.githubusercontent.com/KhronosGroup/SPIRV-Headers/master/include/spirv/1.0/spirv.json'

cd "${0%/*}/../src/gen"

curl -sSL "$URL" | jq -r '
	.spv |
	["pub const magic_number =", .meta.MagicNumber, ";"],
	["pub const version =", .meta.Version, ";"],
	(.enum[] |
		["\npub const", .Name, "= enum(u16) {"],
		(.Values |
			. as $values |
			keys_unsorted[] |
			[., "=", $values[.], ","]
		),
		["};"]
	)
	| join(" ")
' | zig fmt --stdin >spirv.zig
