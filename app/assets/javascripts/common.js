// --- Navbar for Mobile ---
/*
  function: M.Sidenav.init(elems, options)
  options:  https://materializecss.com/sidenav.html#options
*/
document.addEventListener('DOMContentLoaded', function() {
  var elems = document.querySelectorAll('.sidenav');
  var instances = M.Sidenav.init(elems, 'edge');
});
