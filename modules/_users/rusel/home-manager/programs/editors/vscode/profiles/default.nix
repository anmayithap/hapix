{
  flake.modules.homeManager.rusel-vscode = {lib, ...}: {
    programs.vscode.profiles.default = {
      enableExtensionUpdateCheck = lib.mkDefault false;
      enableMcpIntegration = lib.mkDefault false;
      enableUpdateCheck = lib.mkDefault false;

      keybindings = lib.mkBefore [
        {
          key = "ctrl+alt+o";
          command = "editor.action.organizeImports";
          when = ''
            "textInputFocus
            && !editorReadonly
            && supportedCodeAction =~ /(\\s|^)source\\.organizeImports\\b/"
          '';
        }
        {
          key = "shift+alt+o";
          command = "-editor.action.organizeImports";
          when = ''
            textInputFocus
            && !editorReadonly
            && supportedCodeAction =~ /(\\s|^)source\\.organizeImports\\b/
          '';
        }
        {
          key = "ctrl+alt+l";
          command = "notebook.format";
          when = ''
            notebookEditable
            && !editorTextFocus
            && activeEditor == 'workbench.editor.notebook'
          '';
        }
        {
          key = "ctrl+shift+i";
          command = "-notebook.format";
          when = ''
            notebookEditable
            && !editorTextFocus
            && activeEditor == 'workbench.editor.notebook'
          '';
        }
        {
          key = "ctrl+alt+l";
          command = "notebook.formatCell";
          when = ''
            editorHasDocumentFormattingProvider
            && editorTextFocus
            && inCompositeEditor
            && notebookEditable
            && !editorReadonly
            && activeEditor == 'workbench.editor.notebook'
          '';
        }
        {
          key = "ctrl+shift+i";
          command = "-notebook.formatCell";
          when = ''
            editorHasDocumentFormattingProvider
            && editorTextFocus
            && inCompositeEditor
            && notebookEditable
            && !editorReadonly
            && activeEditor == 'workbench.editor.notebook'
          '';
        }
        {
          key = "ctrl+alt+l";
          command = "editor.action.formatDocument";
          when = ''
            editorHasDocumentFormattingProvider
            && editorTextFocus
            && !editorReadonly
            && !inCompositeEditor
          '';
        }
        {
          key = "ctrl+shift+i";
          command = "-editor.action.formatDocument";
          when = ''
            editorHasDocumentFormattingProvider
            && editorTextFocus
            && !editorReadonly
            && !inCompositeEditor
          '';
        }
        {
          key = "ctrl+alt+l";
          command = "editor.action.formatDocument.none";
          when = ''
            editorTextFocus
            && !editorHasDocumentFormattingProvider
            && !editorReadonly
          '';
        }
        {
          key = "ctrl+shift+i";
          command = "-editor.action.formatDocument.none";
          when = ''
            editorTextFocus
            && !editorHasDocumentFormattingProvider
            && !editorReadonly
          '';
        }
        {
          key = "ctrl+alt+o";
          command = "-workbench.action.remote.showMenu";
        }
        {
          key = "cmd+e";
          command = "workbench.action.toggleAuxiliaryBar";
        }
        {
          key = "alt+cmd+b";
          command = "-workbench.action.toggleAuxiliaryBar";
        }
        {
          key = "alt+cmd+o";
          command = "-workbench.action.remote.showMenu";
        }
        {
          key = "shift+alt+f";
          command = "-editor.action.formatDocument.none";
          when = ''
            editorTextFocus
            && !editorHasDocumentFormattingProvider
            && !editorReadonly
          '';
        }
        {
          key = "shift+alt+f";
          command = "-notebook.format";
          when = ''
            notebookEditable
            && !editorTextFocus
            && activeEditor == 'workbench.editor.notebook'
          '';
        }
        {
          key = "shift+alt+f";
          command = "-notebook.formatCell";
          when = ''
            editorHasDocumentFormattingProvider
            && editorTextFocus
            && inCompositeEditor
            && notebookEditable
            && !editorReadonly
            && activeEditor == 'workbench.editor.notebook'
          '';
        }
        {
          key = "cmd+k cmd+f";
          command = "-editor.action.formatSelection";
          when = ''
            editorHasDocumentSelectionFormattingProvider
            && editorTextFocus
            && !editorReadonly
          '';
        }
        {
          key = "shift+alt+f";
          command = "-editor.action.formatDocument";
          when = ''
            editorHasDocumentFormattingProvider
            && editorTextFocus
            && !editorReadonly
            && !inCompositeEditor
          '';
        }
      ];

      userSettings = lib.mkBefore {
        /*
        --------------
        Update section
        --------------
        */

        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "workbench.welcomePage.extraAnnouncements" = false;

        /*
        -----------------
        Telemetry section
        -----------------
        */

        "telemetry.telemetryLevel" = "off";
        "telemetry.editStats.enabled" = false;
        "telemetry.feedback.enabled" = false;
        "workbench.enableExperiments" = false;
        "workbench.settings.enableNaturalLanguageSearch" = false;
        "workbench.commandPalette.experimental.enableNaturalLanguageSearch" = false;

        /*
        ------------------
        Extensions section
        ------------------
        */

        "extensions.showRecommendationsOnlyOnDemand" = true;
        "extensions.ignoreRecommendations" = true;

        /*
        -----------------
        Debugging section
        -----------------
        */

        "debug.allowBreakpointsEverywhere" = true;
        "debug.breakpointsView.presentation" = "tree";
        "debug.closeReadonlyTabsOnEnd" = true;
        "debug.confirmOnExit" = "always";
        "debug.hideSlowPreLaunchWarning" = true;
        "debug.console.closeOnEnd" = true;
        "debug.internalConsoleOptions" = "openOnSessionStart";
        "debug.openDebug" = "openOnSessionStart";
        "debug.showBreakpointsInOverviewRuler" = true;
        "debug.showInlineBreakpointCandidates" = true;
        "debug.showVariableTypes" = true;
        "debug.terminal.clearBeforeReusing" = true;

        /*
        --------------
        Editor section
        --------------
        */

        "editor.fontSize" = 13;
        "editor.fontFamily" = "'JetBrainsMono NF'";
        "editor.wordWrap" = "on";
        "editor.aiStats.enabled" = false;
        "editor.autoIndentOnPasteWithinString" = true;
        "editor.bracketPairColorization.enabled" = true;
        "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
        "editor.dragAndDrop" = false;
        "editor.experimentalWhitespaceRendering" = "off";
        "editor.folding" = false;
        "editor.glyphMargin" = false;
        "editor.suggestOnTriggerCharacters" = false;
        "editor.acceptSuggestionOnCommitCharacter" = false;
        "editor.tabCompletion" = "on";
        "editor.suggestSelection" = "first";
        "editor.suggest.localityBonus" = true;
        "editor.scrollbar.horizontal" = "hidden";
        "editor.scrollbar.vertical" = "auto";
        "editor.inlineSuggest.syntaxHighlightingEnabled" = true;
        "accessibility.verbosity.inlineChat" = false;

        /*
        ------------
        Goto section
        ------------
        */

        "editor.gotoLocation.alternativeDeclarationCommand" = "editor.action.goToReferences";
        "editor.gotoLocation.alternativeDefinitionCommand" = "editor.action.goToReferences";
        "editor.gotoLocation.alternativeImplementationCommand" = "editor.action.goToReferences";
        "editor.gotoLocation.alternativeReferenceCommand" = "editor.action.goToReferences";
        "editor.gotoLocation.alternativeTypeDefinitionCommand" = "editor.action.goToReferences";
        "editor.gotoLocation.multipleReferences" = "peek";
        "editor.gotoLocation.multipleDefinitions" = "peek";
        "editor.gotoLocation.multipleDeclarations" = "peek";
        "editor.gotoLocation.multipleImplementations" = "peek";
        "editor.gotoLocation.multipleTypeDefinitions" = "peek";

        /*
        ------------
        Find section
        ------------
        */

        "editor.find.cursorMoveOnType" = false;
        "editor.find.history" = "never";
        "editor.find.replaceHistory" = "never";

        /*
        -----------
        SCM section
        -----------
        */

        "scm.defaultViewMode" = "tree";
        "scm.diffDecorationsGutterPattern" = {
          "added" = true;
          "modified" = true;
        };
        "scm.repositories.selectionMode" = "multiple";
        "scm.repositories.explorer" = false;

        /*
        --------------
        Window section
        --------------
        */

        "window.newWindowDimensions" = "maximized";
        "window.commandCenter" = false;

        /*
        ------------
        Diff section
        ------------
        */

        "diffEditor.codeLens" = true;
        "diffEditor.experimental.showMoves" = true;

        /*
        ----------------
        Explorer section
        ----------------
        */

        "explorer.compactFolders" = false;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.autoOpenDroppedFile" = false;

        /*
        -----------------
        Workbench section
        -----------------
        */

        "workbench.activityBar.location" = "default";
        "workbench.commandPalette.experimental.suggestCommands" = true;
        "workbench.startupEditor" = "none";
        "workbench.statusBar.visible" = true;
        "workbench.tips.enabled" = false;
        "workbench.settings.editor" = "json";
        "workbench.remoteIndicator.showExtensionRecommendations" = false;
        "workbench.tree.enableStickyScroll" = false;
      };
    };
  };
}
