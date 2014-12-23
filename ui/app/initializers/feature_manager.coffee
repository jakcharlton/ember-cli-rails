FeatureManagerInitializer =
  name: 'feature-manager'
  initialize: (container, app) ->
    app.inject 'controller', 'featureManager', 'service:featureManager'

`export default FeatureManagerInitializer;`
