#!/bin/bash
#shellcheck disable=SC2155
set -eo pipefail

DOCS_DIR=$1
DIFF_DIR=$2
REF=$3

[[ -z $DOCS_DIR || -z $TARGETS ]] && {
	echo "Usage: $0 <docs_dir> <diff_dir> [ref]"
	exit 1
}

cleanup() {
	rm -f "$VERSION_SCRIPT" "$DOCS_SCRIPT"
}

mkdir -p "$DOCS_DIR" "$DIFF_DIR"

VERSION_SCRIPT=./scripts/get_tlt_version.sh
DOCS_SCRIPT=./scripts/gen-desc.py

[[ -n $REF ]] && {
	cp "$VERSION_SCRIPT" "$DOCS_SCRIPT" ./
	VERSION_SCRIPT=./get_tlt_version.sh
	DOCS_SCRIPT=./gen-desc.py
	git checkout "$REF" || {
		cleanup
		exit 1
	}
}

# dummy run to avoid version weirdness
$VERSION_SCRIPT >/dev/null
VERSION_CURRENT=$($VERSION_SCRIPT | cut -d'_' -f2-)
VERSION_PREVIOUS=$($VERSION_SCRIPT --previous | cut -d'_' -f2-)

for TARGET in $(./select.sh | tail -n1 | grep -oP '(?<=^|\s).{1,6}(?=\s|$)'); do
	$DOCS_SCRIPT --descriptions-only --family "${TARGET}"

	export FILE=${DOCS_DIR}/${TARGET^^}_${VERSION_CURRENT}.json
	mv "out/${TARGET}.json" "$FILE"
	[[ $CI_COMMIT_REF_PROTECTED == "true" ]] && cp "$FILE" out/ # save for caching

	[[ -n $REF ]] && continue

	export PREVIOUS_F=${TARGET^^}_${VERSION_PREVIOUS}.json
	export DIFF_FILE=${DIFF_DIR}/${PREVIOUS_F%.json}-${VERSION_CURRENT}.diff
	json-diff --sort "out/$PREVIOUS_F" "$FILE" >"$DIFF_FILE" || true
	sed -i -E -e '/^\s+\.\.\.$/d' "$DIFF_FILE"
done

[[ -z $REF ]] || {
	git checkout -
	cleanup
}
