# ==UserScript==
# @name         mb. EDIT RECORDINGS
# @version      2013.0624.1447
# @description  musicbrainz.org release page: Add an edit link to the recordings and allow some editing inline.
# @namespace    http://userscripts.org/scripts/show/XXX
# @author       Mathieu Arnold (mat/mat813)
# @licence      CC BY-NC-SA 3.0 FR (http://creativecommons.org/licenses/by-nc-sa/3.0/fr/)
# @since        2013.06.24.
# @grant        none
# @include      *://*musicbrainz.org/release/*
# @exclude      *://*musicbrainz.org/release/add
# @exclude      *://*musicbrainz.org/release/add?artist*
# @exclude      *://*musicbrainz.org/release/add?release-group*
# @exclude      *://*musicbrainz.org/release/*annotation*
# @exclude      *://*musicbrainz.org/release/*cover-art*
# @exclude      *://*musicbrainz.org/release/*/relationships
# @exclude      *://*musicbrainz.org/release/*/discids
# @exclude      *://*musicbrainz.org/release/*/tags
# @exclude      *://*musicbrainz.org/release/*/details
# @exclude      *://*musicbrainz.org/release/*/edit
# @exclude      *://blog.musicbrainz.org*
# @exclude      *://bugs.musicbrainz.org*
# @exclude      *://forums.musicbrainz.org*
# @exclude      *://lists.musicbrainz.org*
# @exclude      *://tickets.musicbrainz.org*
# @exclude      *://wiki.musicbrainz.org*
# @run-at       document-end
# ==/UserScript==
# - --- - --- - --- - START OF CONFIGURATION - --- - --- - --- - 
editRecordingText = "edit"
# - --- - --- - --- - END OF CONFIGURATION - --- - --- - --- - 
getRelMBID = ->
  mbid = self.location.href.match(/musicbrainz\.org\/[^/]+\/([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})/i)
  if mbid
    mbid[1]
  else
    null
addAfter = (n, e) ->
  if n and e
    if e.nextSibling
      e.parentNode.insertBefore n, e.nextSibling
    else
      e.parentNode.appendChild n
  else
    null
createA = (text, link, title, target) ->
  a = document.createElement("a")
  if link
    a.setAttribute "href", link
  else
    a.style.setProperty "cursor", "pointer"
  if typeof text is "string"
    a.appendChild document.createTextNode(text)
  else
    a.appendChild text
  a.setAttribute "title", title  if title
  a.setAttribute "target", target  if target
  return a

relMBID = getRelMBID()
if relMBID and (tracksHtml = document.querySelectorAll("div#content tbody[about^='[mbz:release/'] tr[typeof='mo:Track']")).length > 0
  for track in tracksHtml
    if rec = track.querySelector("a[rel='mo:publication_of']")
      s = document.createElement("span")
      s.style.setProperty('float', 'right')
      s.appendChild createA(editRecordingText, rec.getAttribute("href")+"/edit", "edit this recording")
      addAfter s, rec
