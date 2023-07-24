u = up.util
$ = jQuery

findMetas = ->
  document.head.querySelectorAll('title, meta, link:not([rel=stylesheet])')

beforeAll ->
  jasmine.locationBeforeSuite = location.href
  jasmine.titleBeforeSuite = document.title

afterAll ->
  # Webkit ignores replaceState() calls after 100 calls / 30 sec.
  # Hence we only call it when the history was actually changed.
  unless up.util.matchURLs(location.href, jasmine.locationBeforeSuite)
    history.replaceState?({ fromResetPathHelper: true }, '', jasmine.locationBeforeSuite)

    for meta in findMetas()
      meta.remove()

    for savedMeta in jasmine.metasBeforeExample
      document.head.append(savedMeta)

beforeEach ->
  # Webkit ignores replaceState() calls after 100 calls / 30 sec.
  # So specs need to explicitly enable history handling.
  up.history.config.enabled = false

  # Store original URL and title so specs may use it
  jasmine.locationBeforeExample = location.href
  jasmine.metasBeforeExample = findMetas()

afterEach ->
  up.viewport.root.scrollTop = 0
