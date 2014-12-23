`import Ember from 'ember';`

FeatureManager = Ember.Object.extend
  init: ->
    @_super()
    @set 'SHOW_PONY', window.ENV?.SHOW_PONY or false
    @set 'AB', window.ENV?.AB or 'A'

    @set 'isMarketer', @get('AB') is 'A'
    @set 'isEducator', !@get('isMarketer')

`export default FeatureManager;`