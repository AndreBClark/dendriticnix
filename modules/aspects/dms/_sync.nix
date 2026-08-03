{ pkgs, config, ... }:
let
  nixConfigRepo =
    if config.programs.nh.flake != null then
      config.programs.nh.flake
    else
      "${config.home.homeDirectory}/nixconfig";
in
pkgs.writeShellApplication {
  name = "dms-sync";
  runtimeInputs = [
    pkgs.jq
    pkgs.dms-shell
  ];
  text = ''
    # Target file path using variable
    TARGET_FILE="${nixConfigRepo}/modules/aspects/dms/settings.json"

    # Search for the most recent DMS settings entry containing currentThemeName
    SEARCH_RESULT=$(dms cl search --limit 1 '"currentThemeName":' --json 2>/dev/null)

    # Extract the ID from the search result
    ENTRY_ID=$(echo "$SEARCH_RESULT" | jq -r '.entries[0].id // empty')

    if [ -z "$ENTRY_ID" ]; then
      echo "No settings.json entry found in clipboard history" >&2
      exit 1
    fi

    # Get the clipboard data and validate it's JSON
    CLIPBOARD_DATA=$(dms cl paste)

    # Validate the data is valid JSON
    if ! echo "$CLIPBOARD_DATA" | jq empty 2>/dev/null; then
      echo "Error: Clipboard data is not valid JSON" >&2
      exit 1
    fi

    # Additional validation: Check for required DMS settings keys
    if ! echo "$CLIPBOARD_DATA" | jq -e 'has("configVersion") and has("currentThemeName")' >/dev/null 2>&1; then
      echo "Error: Clipboard data does not appear to be DMS settings (missing required keys)" >&2
      exit 1
    fi

    # Write the validated data to file
    if echo "$CLIPBOARD_DATA" > "$TARGET_FILE"; then
      echo "Successfully replaced settings.json with validated clipboard data"

      # Change to repository directory before git operations
      cd "${nixConfigRepo}" || {
        echo "Warning: Failed to change to repository directory" >&2
        exit 1
      }

      # Add the updated file to git
      if git add "$TARGET_FILE"; then
        echo "File staged in git"
      else
        echo "Warning: Failed to stage file in git" >&2
      fi
    else
      echo "Failed to write to file" >&2
      exit 1
    fi
  '';
}
