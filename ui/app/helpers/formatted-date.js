import Ember from 'ember';

export function formattedDate(input) {
  return input;
}

export default Ember.Handlebars.makeBoundHelper(formattedDate);
