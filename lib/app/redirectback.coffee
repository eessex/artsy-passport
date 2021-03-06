#
# Redirects back based on query params, session, or w/e else.
# Code stolen from Force, thanks @dzucconi!
#
opts = require '../options'
sanitizeRedirect = require './sanitize_redirect'

module.exports = (req, res) ->
  url = sanitizeRedirect(
    req.session.redirectTo or
    (opts.afterSignupPagePath if req.artsyPassportSignedUp and !req.session.skipOnboarding) or
    req.body['redirect-to'] or
    req.query['redirect-to'] or
    req.params.redirect_uri or
    '/'
  )
  delete req.session.redirectTo
  delete req.session.skipOnboarding
  res?.redirect url
  return url
