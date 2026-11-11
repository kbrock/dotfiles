# dotfiles — todo / not-yet-automated

## QuickLook for .mkv (and other non-Apple video formats)

macOS 15+ replaced the old `.qlgenerator` plugin model with app extensions
(`.appex` bundles inside an app's `Contents/Extensions/`). The Homebrew
`quicklook-video` cask installs as `/Applications/QuickLook Video.app` — its
extensions don't auto-register, so Space on a `.mkv` shows only the generic
cone icon until you do this. None of these steps alone was enough; all were
needed.

1. **Install:**
   ```
   brew install --cask quicklook-video
   ```

2. **Launch the app once** so macOS sees the extension bundle:
   ```
   open "/Applications/QuickLook Video.app"
   ```
   Then quit it.

3. **Approve every Privacy & Security prompt that pops** during/after first
   launch — including the "QuickLook Video would like to control your
   computer" / accessibility-style dialog. Without this, the extensions can
   load but won't be allowed to run. If you missed the popup, check
   **System Settings → Privacy & Security** for an "Allow" button.

4. **Enable Media Extensions** in **System Settings → General → Login Items
   & Extensions**:
   - Turn on **QLVideo Formats** (under Media Extensions)
   - Turn on **QLVideo Codecs** (under Media Extensions)
   - Toggle the **Spotlight** entry for QuickLook Video off→on as a
     re-register kick (even if it was already on).

5. **Force-register the appex bundles** with pluginkit (this is the part
   that finally made it work for me):
   ```
   pluginkit -a "/Applications/QuickLook Video.app/Contents/Extensions/QLVideo Formats.appex"
   pluginkit -a "/Applications/QuickLook Video.app/Contents/Extensions/QLVideo Codecs.appex"
   ```

6. **Explicitly mark them as enabled** (separate from just being registered):
   ```
   pluginkit -e use -i $(defaults read "/Applications/QuickLook Video.app/Contents/Extensions/QLVideo Formats.appex/Contents/Info" CFBundleIdentifier)
   pluginkit -e use -i $(defaults read "/Applications/QuickLook Video.app/Contents/Extensions/QLVideo Codecs.appex/Contents/Info" CFBundleIdentifier)
   ```

7. **Bounce Quick Look and Finder:**
   ```
   qlmanage -r && qlmanage -r cache && killall Finder
   ```

8. **Verify:**
   ```
   qlmanage -m | grep -i mk
   pluginkit -mAvvv | grep -i qlvideo
   ```
   First should show an mkv handler; second should show both extensions
   with `+` (enabled), not `-`.

> Anything else? I (Claude) may have missed steps — Keenan added more
> permission grants than I captured in this transcript. Revise as needed.
