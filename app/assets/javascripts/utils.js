function goto_commit(url, commit) {
  url = url.replace(".git", "");
  window.open(url + "/commit/" + commit, '_blank');
}

function compare_log() {
  levels = document.getElementsByName("r_difftype");
  level = 2
  for (i = 0; i < levels.length; i++) {
    if (levels[i].checked) {
      level = levels[i].value;
      break;
    }
  }
  id1 = document.getElementById("r_id1").value;
  id2 = document.getElementById("r_id2").value;
  window.open("/show_diff/" + id1 + "/" + id2 + "/" + level, '_blank');
}

function open_splited(id) {
  controller = document.getElementById("spliter_" + id);
  targets = document.getElementsByClassName("splited_" + id);

  if (targets.length <= 0) return;

  if (targets[0].style.display == "none") {
    for (i = 0; i < targets.length; i++) {
      targets[i].style.display = "table-row";
    }
    controller.innerHTML = "<i class='angle up icon'></i>"
  } else {
    for (i = 0; i < targets.length; i++) {
      targets[i].style.display = "none";
    }
    controller.innerHTML = "<i class='angle down icon'></i>"
  }
}
