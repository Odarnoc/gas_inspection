import { Quasar } from 'quasar'

// ! NOTICE ssrContext param:
export default async ({ ssrContext }) => {
  const langIso = 'en-us' // ... some logic to determine it (use Cookies Plugin?)

  try {
    await import(
      'quasar/lang/' + langIso
    )
      .then(lang => {
        // ! NOTICE ssrContext param:
        Quasar.lang.set(lang.default, ssrContext)
      })
  } catch (err) {
    // Requested Quasar Language Pack does not exist,
    // let's not break the app, so catching error
  }
}
