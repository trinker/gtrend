NEWS
====

Versioning
----------

Releases will be numbered with the following semantic versioning format:

&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor 
  and patch)

* New additions without breaking backward compatibility bumps the minor 
  (and resets the patch)

* Bug fixes and misc changes bumps the patch

&lt;b&gt;CHANGES&lt;/b&gt; IN <a href="https://github.com/trinker/gtrend" target="_blank">gtrend</a> VERSION 0.1.1
----------------------------------------------------------------

BUGS

* `gtend_scraper` used  the following approach to deal with multi-word terms:
  `phrases &lt;- gsub("\\s+", "\\+", gsub("[-,]", " ", phrases))` when it should
  have been enclosed with quotes:
  `phrases &lt;- sprintf("\"%s\"", gsub("[-,]", " ", phrases))` as seen:
  https://support.google.com/trends/answer/4359582?hl=en&ref_topic=4365599 
  Spotted by David Serfass.


&lt;b&gt;CHANGES&lt;/b&gt; IN <a href="https://github.com/trinker/gtrend" target="_blank">gtrend</a> VERSION 0.1.0
----------------------------------------------------------------

* The first installation of the <a href="https://github.com/trinker/gtrend" target="_blank">gtrend</a> package

* Package designed to wraps the functionlity of the GTrendsR package into 
  convenient wrappers that grab and format trend data from Google.