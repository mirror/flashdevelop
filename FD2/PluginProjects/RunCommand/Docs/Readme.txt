Copyright (c) 2006 Philippe Elsass
RunCommand plugin for FlashDevelop


1. Installation

- close FlashDevelop
- copy RunCommand.dll in the <FD>/plugins/ directory
- edit <FD>/settings/MainMenu.xml or <FD>/settings/ToolBar.xml
and add custom 'Run' and 'Edit' commands to your convenience


2. 'Run' command

Execute a process captured from the project root directory.

<!-- basic usage -->
<button label="Ant" click="PluginCommand" image="23" tag="Run;ant" />

<!-- save .as files before execution -->
<button label="Ant" click="PluginCommand" image="23" tag="Run;SaveAS;ant" />

<!-- save all files before execution -->
<button label="Ant" click="PluginCommand" image="23" tag="Run;SaveAll;ant" />


3. 'Edit' command

Open a file for edition in FlashDevelop.

<!-- edit the project's build file -->
<button label="build.xml" click="PluginCommand" image="7" tag="Edit;@PROJECTDIR\build.xml" />
