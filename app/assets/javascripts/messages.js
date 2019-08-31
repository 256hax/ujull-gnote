/* --- Count Input Text in new action --- */
function ShowTextLength(str) {
  document.getElementById("inputlength").innerHTML = str.length;
}

/* --- Key shortcut for submit "Ctrl/command + Enter" --- */
window.addEventListener("keydown", handleKeydown);

function handleKeydown(event){
  // --- Post message ---
  // Value: event.metaKey => command key, event.ctrlKey => Ctrl key, keyCode 13 => Enter key
  // Return: Get true when command/Ctrl + enter.
  var command_enter_keys = ((event.metaKey || event.ctrlKey) && event.keyCode == 13);
  if (command_enter_keys == true) {
    // usage: document.[form name].submit()
    // form name ex: <form name="messageForm" ...
    document.messageForm.submit();
  }

  // --- Move new message form page ---
  // event.altKey => alt key, event.keyCode 78 => N key
  var alt_n_keys = (event.altKey && event.keyCode == 78);
  if (alt_n_keys == true) {
    setTimeout("link()", 0);
    location.href='/messages/new/';
  }

  // --- Move top page ---
  // event.altKey => alt key, event.keyCode 84 => T key
  var alt_t_keys = (event.altKey && event.keyCode == 84);
  if (alt_t_keys == true) {
    setTimeout("link()", 0);
    location.href='/';
  }
}
