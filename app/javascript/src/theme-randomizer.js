document.addEventListener("DOMContentLoaded", function () {
  setLabelText();
  let themeChooser = document.getElementById("theme-chooser");
  themeChooser.addEventListener("click", function() {
    updateTheme(themeChooser)
    updateIcon(themeChooser);
  })
});

function setLabelText() {
  let orcLabel = document.getElementById("theme-for-orcs");
  let elfLabel = document.getElementById("theme-for-elves");
  elfLabel.innerHTML = generateLabel(elfTheme, randomizeIndex(elfTheme));
  orcLabel.innerHTML = generateLabel(orcTheme, randomizeIndex(orcTheme));
}

function generateLabel(theme, i) {
  return theme[i] + ", " + theme[i + 1] + " " + cretin[randomizeIndex(cretin)];
}

function randomizeIndex(theme) {
  return Math.floor(Math.random() * theme.length);
}

function updateIcon(checkboxState) {
  let switchPaddle = document.querySelector(".switch-paddle");
  if (checkboxState.checked) {
    switchPaddle.classList.remove("fab");
    switchPaddle.classList.add("fas");
  } else {
    switchPaddle.classList.remove("fas");
    switchPaddle.classList.add("fab");
  }
}

function updateTheme(checkboxState) {
  let body = document.querySelector("body");
  checkboxState.checked ? body.classList.add("dark") : body.classList.remove("dark");
}

const orcTheme = [
'evil',
'bad',
'immoral',
'devilish',
'corrupt',
'flagitious',
'foul',
'hellish',
'dismal',
'pessimistic',
'cheerless',
'drab',
'sober',
'discouraging',
'dingy',
'sombre',
'frowning',
'sullen',
'untaught',
'ignorant',
'uneducated',
'unenlightened',
'unlettered',
'in the dark',
'unlit',
'dirty',
'cimmerian',
'dun',
'dim',
'dusk',
'mystical',
'abstruse',
'cabbalistic',
'enigmatic',
'incomprehensible',
'secret',
'confidential',
'concealed',
'cryptic',
'hidden',
'mysterious',
'silent',
'reticent',
'maggoty',
'oozey'
];

const elfTheme = [
  'nimble',
  'airy',
  'effortless',
  'easy',
  'sterling',
  'buoyant',
  'weightless',
  'easy',
  'lightsome',
  'blanched',
  'fair',
  'happy',
  'carefree',
  'cheerful',
  'cheery',
  'crisp',
  'minty',
  'gay',
  'light-hearted',
  'righteous',
  'easy',
  'giddy',
  'lightsome',
  'unsubstantial',
  'squeaky clean',
  'wholesome',
  'slight',
  'upstanding',
  'pious',
  'angelic',
  'dizzy',
  'light-headed',
  'delirious',
  'giddy'
];

const cretin = [
  'witch',
  'warlock',
  'vampire',
  'ghoul',
  'poltergeist',
  'devil',
  'elf',
  'spirit',
  'pixie',
  'enchantress',
  'fay',
  'leprechaun',
  'changeling',
  'cat-being',
  'demagogue',
  'hatchling',
  'siren',
  'knave',
  'knight',
  'sorcerous',
  'sphinx',
  'globlin',
  'hag',
  'banker',
  'cretin',
  'ooze',
  'bog monster',
  'hobbit',
  'dragon',
  'sloth beast',
  'owl thing',
  'thing',
  'moon man',
  'night witch'
];