$(document).ready ->
  $("label.tree-toggler").click ->
    $(this).parent().children("ul.tree").toggle 300
