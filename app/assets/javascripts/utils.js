function goto_commit(url, commit) {
  url = url.replace(".git", "");
  window.open(url + "/commit/" + commit, '_blank');
}

function compare_log() {
  id1 = document.getElementById("r_id1").value;
  id2 = document.getElementById("r_id2").value;
  window.open("/show_diff/" + id1 + "/" + id2, '_blank');
}
