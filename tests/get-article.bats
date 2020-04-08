#!/usr/bin/env bats

@test "get-article: get wikipedia articles" {
  articles=$(find ${BATS_TEST_DIRNAME}/fixtures/articles -type f)
  for article in $articles; do
    album=$(basename ${article})

    out=$(mktemp)
    bash ${BATS_TEST_DIRNAME}/../share/get-article "https://en.wikipedia.org/wiki/${album}" >$out
    [ $? -eq 0 ] || {
      echo $album
      exit 1
    }

    run diff $out $article
    [ "$status" -eq 0 ] || {
      echo $album
      diff $out $article
      exit 1
    }
  done
}
