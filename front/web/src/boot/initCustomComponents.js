const requireComponent = require.context('components', true, /[\w]+\.vue$/) // require the base components in the components directory.

export default async ({ app }) => {
  requireComponent.keys().forEach(fileName => {
    const componentConfig = requireComponent(fileName)
    const componentName = fileName.split('/').pop().split('.')[0]
    app.component(componentName, componentConfig.default || componentConfig) // register globally the base components in the Vue instance
  })
}
