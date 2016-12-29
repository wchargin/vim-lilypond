vim-lilypond
============

This is a fork of the vim plugin for Lilypond, which simplifies the
filetype recognition and syntax coloring for Lilypond files.

This plugin currently only includes the vim code distributed with
Lilypond. In the future, it may include additional functionality.

.. _Lilypond documentation: http://lilypond.org/doc/v2.14/Documentation/usage/text-editor-support

The original plugin comes from http://lilypond.org. Specific information
about Vim mode for Lilypond can be found in the `Lilypond documentation`_

The original plugin is released under the `GNU General Public License
Version 3`_. All modifications are licensed likewise.

.. _GNU General Public License Version 3: http://lilypond.org/doc/v2.14/Documentation/web/gpl

Written for Lilypond 2.18.

Options
-------

Extended note types
^^^^^^^^^^^^^^^^^^^

By default, only the Dutch note types are recognized and highlighted,
for performance reasons. To recognize other note types, like
``csharpsharp`` or ``dokk`` for the Dutch ``cisis``, add ::

    let g:lilypond_extended_notes = 1

to your .vimrc file before loading the plugin.
