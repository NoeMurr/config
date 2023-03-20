
-- startup screen configuration
-- getting the startify theme settings for modification
startify_settings = require('startup.themes.startify')

startify_settings.body = startify_settings.body_2
startify_settings.parts = {'header', 'body', 'bookmarks'}

require('startup').setup(startify_settings)
