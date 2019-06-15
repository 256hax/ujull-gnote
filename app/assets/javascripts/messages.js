/* --- Count Input Text in new action --- */
function ShowTextLength(str) {
  document.getElementById("inputlength").innerHTML = str.length;
}

/* --- Key shortcut for submit "Ctrl/command + Enter" --- */
window.addEventListener("keydown", handleKeydown);

function handleKeydown(event){
  // Value: metaKey => command key, ctrlKey => Ctrl key, keyCode 13 => Enter key
  // Return: Get true when Ctrl/command + Enter.
  var submit_keys = ((event.metaKey || event.ctrlKey) && event.keyCode == 13);
  if (submit_keys == true) {
    // usage: document.[form name].submit()
    // form name ex: <form name="messageForm" ...
    document.messageForm.submit();
  }
}
