import Rails from 'rails-ujs';
import * as ActiveStorage from 'activestorage';

Rails.start();
ActiveStorage.start();

import '../src/foundation-setup.js'
import '../src/theme-randomizer.js'
