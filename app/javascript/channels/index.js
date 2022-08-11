// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

//Copyright information for footer
const today = new Date();
const thisYear = today.getFullYear();
footer = document.querySelector('footer');
copyright = document.createElement('p');
copyright.innerHTML = `&#169; ${thisYear} <span>Unite || CTD Final</span>`;

footer.prepend(copyright);
