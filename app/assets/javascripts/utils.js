function goto_commit(url, commit) {
  url = url.replace(".git", "");
  window.open(url + "/commit/" + commit, '_blank');
}
