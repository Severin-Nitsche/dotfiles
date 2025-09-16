import Quickshell
import QtQuick
pragma Singleton

Singleton {
  id: root
  property int barHeight: 5 // mm
  property bool showDebug: true // unused LOL

  property bool darkMode: false

  property int minLogomarkDensity: 4

  // Format: YYYY-MM-dd
  // Year is unused
  property date transDayOfVisibility: '2009-03-31'
  property date prideSeasonStart: '1969-06-01'
  property date prideSeasonEnd: '1969-06-30'

  property url transLogomark: 'icons/nixos-logomark-trans-gradient-none.svg'
  property url prideLogomark: 'icons/nixos-logomark-rainbow-gradient-none.svg'
  property url darkLogomark: 'icons/nixos-logomark-white-flat-none.svg'
  property url lightLogomark: 'icons/nixos-logomark-black-flat-none.svg'

  property url darkLogotype: 'icons/nixos-logotype-white-regular-none.svg'
  property url lightLogotype: 'icons/nixos-logotype-black-regular-none.svg'

  // Colors
  property color lightBarBackground: '#c0f0ffff' // 'azure'
  property color lightBarHighlight: 'mediumseagreen'

  property color darkBarBackground: 'darkslategray'
  property color darkBarHighlight: 'royalblue'

  // Computed properties -- Helpers
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
    darkBarBackground :
    lightBarBackground
  property color barHighlight: darkMode ?
    darkBarHighlight :
    lightBarHighlight
}
