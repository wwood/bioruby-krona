# bio-krona

[![Build Status](https://secure.travis-ci.org/wwood/bioruby-krona.png)](http://travis-ci.org/wwood/bioruby-krona)

This biogem is built around [Krona](http://krona.sourceforge.net/), a flashy way of representing hierarchical data.

## Usage

```bio-krona``` is a pretty simple gem, at this stage, and only implements two useful methods. 
The first, the static method ```Bio::Krona#html``` is to call the krona software itself (specifically, ```ktImportText```) to generate
the visualisation in HTML form.

```ruby
require 'bio-krona'

html = Bio::Krona.html({
      ['Sponge','Amphimedon']=>3,
      ['Sponge','Calciums']=>4,
    })

```

It takes as input a hash, where the keys are arrays representing the metadata, and the values are the weightings. In the example above, 
the data has two levels of hierarchy - first Sponge, second Ampphimedon/Calciums.

The second method ```collapse``` implements a pre-processing step that might be of use when the data is overly complex. 
It collapses the data so that only a limited number of hierarchy levels are accounted for. 
The weightings are preseverd by adding up the individual abundances.

```ruby
Bio::Krona.collapse({
   ['Sponge','Amphimedon']=>3,
   ['Sponge','Calciums']=>4,
}, 1)
#=> {['Sponge'] => 7}
``` 

## Installation

```sh
gem install bio-krona
```

## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/wwood/bioruby-krona

The BioRuby community is on IRC server: irc.freenode.org, channel: #bioruby.

## Cite

```bio-krona``` is currently unpublished. However Krona itself is - see http://krona.sourceforge.net

## Biogems.info

This Biogem is published at [#bio-krona](http://biogems.info/index.html)

## Copyright

Copyright (c) 2012 Ben J. Woodcroft. See LICENSE.txt for further details.

