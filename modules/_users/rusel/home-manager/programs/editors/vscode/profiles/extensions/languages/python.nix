{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    unfree = lib.mkAfter [
      pkgs.nix-vscode-extensions.vscode-marketplace.ms-python.vscode-pylance
    ];

    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.vscode-marketplace.ms-python.vscode-pylance
        pkgs.nix-vscode-extensions.vscode-marketplace.ms-python.python
        pkgs.nix-vscode-extensions.vscode-marketplace.ms-python.debugpy
        pkgs.nix-vscode-extensions.vscode-marketplace.ms-python.vscode-python-envs
      ];

      userSettings = lib.mkBefore {
        /*
        ------------------------
        Pylance Extension Section
        ------------------------
        */

        "python.analysis.aiCodeActions" = {
          "implementAbstractClasses" = false;
          "generateSymbol" = false;
          "convertFormatString" = false;
        };
        "python.analysis.autoIndent" = true;
        "python.analysis.autoSearchPaths" = true;
        "python.analysis.autoSplitStrings" = true;
        "python.analysis.diagnosticMode" = "openFilesOnly";
        "python.analysis.enablePerfTelemetry" = false;
        "python.analysis.enablePytestSupport" = true;
        "python.analysis.enableSnippetExtraTelemetry" = false;
        "python.analysis.enableTroubleshootMissingImports" = true;
        "python.analysis.generateWithTypeAnnotation" = true;
        "python.analysis.importFormat" = "absolute";
        "python.analysis.exclude" = [
          "**/node_modules"
          "**/__pycache__"
          "**/.mypy_cache"
          "**/.ruff_cache"
          "**/.pytest_cache"
          "**/.venv"
          "**/.idea"
          "**/.vscode"
          "**/docs/build"
          "**/*.py[co]"
          "**/.DS_Store"
          "**/.git"
        ];
        "python.analysis.inlayHints.callArgumentNames" = "all";
        "python.analysis.inlayHints.pytestParameters" = true;
        "python.analysis.inlayHints.variableTypes" = true;
        "python.analysis.packageIndexDepths" = [
          {
            "name" = "";
            "depth" = 10;
            "includeAllSymbols" = true;
          }
        ];
        "python.analysis.referencesCodeLens" = true;
        "python.analysis.reportExtraTelemetry" = false;
        "python.analysis.supportRestructuredText" = true;
        "python.analysis.typeCheckingMode" = "off";
        "python.analysis.typeEvaluation.analyzeUnannotatedFunctions" = false;
        "python.analysis.typeEvaluation.deprecateTypingAliases" = true;
        "python.analysis.typeEvaluation.enableExperimentalFeatures" = false;
        "python.analysis.typeEvaluation.disableBytesTypePromotions" = true;
        "python.analysis.typeEvaluation.enableTypeIgnoreComments" = true;
        "python.analysis.typeEvaluation.strictParameterNoneValue" = true;

        /*
        ------------------------
        Python Extension Section
        ------------------------
        */

        "python.createEnvironment.trigger" = "off";
        "python.experiments.enabled" = false;
        "python.globalModuleInstallation" = false;
        "python.languageServer" = "Pylance";
        "python.REPL.enableREPLSmartSend" = false;
        "python.REPL.provideVariables" = false;
        "python.terminal.activateEnvInCurrentTerminal" = true;
        "python.terminal.activateEnvironment" = true;
        "python.terminal.shellIntegration.enabled" = true;
        "python.testing.debugPort" = 8383;
        "python.testing.pytestEnabled" = true;
        "python.useEnvironmentsExtension" = true;
        "[python]" = {
          "diffEditor.ignoreTrimWhitespace" = false;
          "editor.defaultColorDecorators" = "never";
          "editor.formatOnType" = true;
          "editor.wordBasedSuggestions" = "off";
        };

        /*
        -------------------------
        Debugpy Extension Section
        -------------------------
        */

        "debugpy.debugJustMyCode" = false;
        "debugpy.showPythonInlineValues" = true;

        /*
        -------------------------------------
        Python Environments Extension Section
        -------------------------------------
        */

        "python-envs.alwaysUseUv" = false;
        "python.terminal.useEnvFile" = true;
      };
    };
  };
}
