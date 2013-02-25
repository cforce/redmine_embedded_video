redmine_embedded_video
======================

Author: Jan Pilz  (see http://www.redmine.org/issues/5171)

Tested redmine 2.1.4 and 2.2.3, with ruby 1.8.7 and ruby 1.9.3.

- git clone into redmine to plugins directory
- rake redmine:plugins:migrate RAILS_ENV=production
- restart redmine

syntax: {{video(<ATTACHEMENT>|<URL>|<YOUTUBE_URL>[,<width>,<height>])}}
