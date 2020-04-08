#!/usr/bin/env bats

@test "parse: wikipedia articles to albums" {
  articles=$(find ${BATS_TEST_DIRNAME}/fixtures/articles -type f)
  for article in $articles; do
    album=$(basename ${article})

    out=$(mktemp)
    bash ${BATS_TEST_DIRNAME}/../share/parse "${article}" >$out
    [ $? -eq 0 ] || {
      echo $album
      exit 1
    }

    run diff $out "${BATS_TEST_DIRNAME}/fixtures/albums/${album}"
    [ "$status" -eq 0 ] || {
      echo $album
      diff $out "${BATS_TEST_DIRNAME}/fixtures/albums/${album}"
      exit 1
    }
  done
}
