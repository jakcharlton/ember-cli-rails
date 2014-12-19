`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType


Router.map ->
  @resource 'contacts', ->
    @resource 'contact', { path: '/:contact_id' } 
  @route 'foo'

`export default Router;`