import Quickshell
import QtQuick
pragma Singleton

Singleton {
  id: root
  property int barHeight: 5 // mm
  property bool showDebug: true // unused LOL

  property bool darkMode: true

  property int minLogomarkDensity: 4

  property real audioStep: 0.04
  property real maxAudio: 1.5

  // Format: YYYY-MM-dd
  // Year is unused
  property date transDayOfVisibility: '2009-03-31'
  property date prideSeasonStart: '1969-06-01'
  property date prideSeasonEnd: '1969-06-30'

  property url icons: Quickshell.shellDir+'/icons/'

  property url transLogomark: icons+'nixos-logomark-trans-gradient-none.svg'
  property url prideLogomark: icons+'nixos-logomark-rainbow-gradient-none.svg'
  property url darkLogomark: icons+'nixos-logomark-white-flat-none.svg'
  property url lightLogomark: icons+'nixos-logomark-black-flat-none.svg'
  property url darkMute: icons+'mute-white.svg'
  property url lightMute: icons+'mute-black.svg'
  property url darkVolume: icons+'volume-white.svg'
  property url lightVolume: icons+'volume-black.svg'
  property url darkDeaf: icons+'deafened-white.svg'
  property url lightDeaf: icons+'deafened-black.svg'
  property url darkLogotype: icons+'nixos-logotype-white-regular-none.svg'
  property url lightLogotype: icons+'nixos-logotype-black-regular-none.svg'
  property url darkCharging: icons+'charging-white.svg'
  property url lightCharging: icons+'charging-black.svg'
  property url darkPower: icons+'power-white.svg'
  property url lightPower: icons+'power-black.svg'

  // Palette
  property list<color> primary: [
    '#eeeeee', // light-pride
    '#cecece', // light
    '#8f8f8f', // light-trans
    '#222222'  // dark
  ] // 58%

  property var secondary: [
    ['#e8effc', '#b7cefd', '#698dd8', '#15213a'],
    ['#e3f1fb', '#a4d5f7', '#3d98d1', '#062437']
  ] // 42%

  property var accent: [
    ['#ededfc', '#cbc7fa', '#8c82d4', '#211d38'],
    // ['#f6eed8', '#dfcc99', '#ac8b26', '#2b2001'],
    ['#ffe5fc', '#e9bee4', '#b873b2', '#2f182d'],
    ['#faebe2', '#f3c2a3', '#c77942', '#341a08'],
    ['#e0f5e5', '#acdcb8', '#4fa46a', '#0c2815'],
    //['#fce9ea', '#f8bcbe', '#ce6e76', '#361719']
  ]

  // Computed properties -- Helpers
  function randomEntry(list) {
    return list[Math.floor(Math.random()*list.length)]
  }

  property list<color> palette: Math.random() < .58 ?
    primary :
    randomEntry(secondary)

  property list<color> highlight: randomEntry(accent)

  property date today: new Date()

  function compareDates(date1, date2) {
    var month1 = date1.getMonth()
    var month2 = date2.getMonth()
    var day1 = date1.getDate()
    var day2 = date2.getDate()

    if (month1 < month2 || (month1 == month2 && day1 < day2)) 
      return -1
    else if (month1 == month2 && day1 == day2)
      return 0
    else
      return 1
  }

  property bool isTransDayOfVisibility: compareDates(transDayOfVisibility, today) == 0
  property bool isPrideSeason: compareDates(prideSeasonStart, today) <= 0 &&
    compareDates(today, prideSeasonEnd) <= 0

  // Computed properties -- Real Shit
  property url logomark: isTransDayOfVisibility ?
    transLogomark :
    isPrideSeason ?
      prideLogomark :
      darkMode ?
        darkLogomark :
	lightLogomark
  property url logotype: darkMode ?
    darkLogotype :
    lightLogotype

  property color barBackground: darkMode ?
    palette[3] :
    isTransDayOfVisibility ?
      palette[2] :
      isPrideSeason ?
        palette[0] :
        palette[1]

  property color transparentBarBackground: {
    let c = barBackground
    Qt.rgba(c.r, c.g, c.b, 0.6)
  }
    
  property color barHighlight: highlight[2]

  property color barText: darkMode ?
    primary[0] :
    primary[3]

  property url mute: darkMode ?
    darkMute :
    lightMute

  property url volume: darkMode ?
    darkVolume :
    lightVolume

  property url deaf: darkMode ?
    darkDeaf : 
    lightDeaf

  property url charging: darkMode ?
    darkCharging : 
    lightCharging

  property url power: darkMode ?
    darkPower : 
    lightPower 
}
