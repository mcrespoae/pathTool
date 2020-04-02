
--Script "Copy the path from files or folders to Skype V1.4"
--Example of OSX NAS path
--/Volumes/BCNMEDIAPROD/80_Client/3M/US0270787 
--/Volumes/BCNAUDIOPROD/02_Client/3M

--Example of OSX old server path
--/Volumes/Media/_PROJECTS/ISL_USE_THIS/ --M
--/Volumes/Quotes/A_L/ --Q
--/Volumes/BCNJOBS/A_L/ --J


--Example of Windows path
--Z:\zz_test\Split
--M:\_PROJECTS\ISL_USE_THIS\01_DELIVERABLES
--Q:\A_L\L'Oreal_EL
--J:\A_L\Amazon\
--\\10.10.210.75\bcnmediaprod\80_Client\ 
--The last path happens when Z is not installed

on run {input, parameters}
	
	--We take the path from the clipboard and save it to myText
	set myText to (input as «class utf8») --We copy the clipboard as utf8
	
	set myText to my searchReplace(myText, "
", "") --We delete \n
	set myText to my searchReplace(myText, "
", "") --We delete \r
	
	
	if (offset of "/Volumes/" in myText) = 0 then --We check if the myText is a real OSX server path looking for the string /Volumes/ inside the path
		if ((offset of "Z:" in myText) = 0 and (offset of "10.10.210.75" in myText) = 0 and (offset of "M:" in myText) = 0 and (offset of "Q:" in myText) = 0 and (offset of "J:" in myText) = 0) then --We check if the myText is a real Windows server path looking for the string Z: Q: M: and J: inside the path. We also look for 10.10.210.75 because somtimes the Windows paths don't have a letter assigned
			display dialog "This is not a valid path" with icon caution giving up after 2 buttons ("OK")
			return
		else
			--This is a valid Windows server path
			set findIt to "Z:\\"
			set replaceIt to "/Volumes/BCNMEDIAPROD/"
			set myText to my searchReplace(myText, findIt, replaceIt)
			
			set findIt to "\\\\10.10.210.75\\bcnmediaprod\\"
			set replaceIt to "/Volumes/BCNMEDIAPROD/"
			set myText to my searchReplace(myText, findIt, replaceIt)
			
			set findIt to "Q:\\"
			set replaceIt to "/Volumes/Quotes/"
			set myText to my searchReplace(myText, findIt, replaceIt)
			
			set findIt to "J:\\"
			set replaceIt to "/Volumes/BCNJOBS/"
			set myText to my searchReplace(myText, findIt, replaceIt)
			
			set findIt to "M:\\"
			set replaceIt to "/Volumes/Media/"
			set myText to my searchReplace(myText, findIt, replaceIt)
			
			
			set findIt to "\\"
			set replaceIt to "/"
			set myText to my searchReplace(myText, findIt, replaceIt)
			
			my openPath(myText)
		end if
		
	else --This is a valid OSX server path
		
		if (offset of "BCNAUDIOPROD" in myText) &gt; 0 then --This is a valid OSX NAS Audio path so we copy it to paste it into Skype		
			set the clipboard to myText
			tell application "Skype" to activate
			return
		end if
		
		set myText to my searchReplace(myText, "&lt;", "")
		set myText to my searchReplace(myText, "&gt;.", "")
		set myText to my searchReplace(myText, "&gt;", "")
		--set myText to characters 10 thru -1 of myText as string --We delete the /Volumes/ Not necessary because we change it to nothing
		
		set findIt to "/Volumes/"
		set replaceIt to ""
		set myText to my searchReplace(myText, findIt, replaceIt)
		
		set findIt to "BCNMEDIAPROD"
		set replaceIt to "Z:"
		set myText to my searchReplace(myText, findIt, replaceIt)
		
		set findIt to "BCNAUDIOPROD"
		set replaceIt to "Z:"
		set myText to my searchReplace(myText, findIt, replaceIt)
		
		set findIt to "Media"
		set replaceIt to "M:"
		set myText to my searchReplace(myText, findIt, replaceIt)
		
		set findIt to "BCNJOBS"
		set replaceIt to "J:"
		set myText to my searchReplace(myText, findIt, replaceIt)
		
		set findIt to "Quotes"
		set replaceIt to "Q:"
		set myText to my searchReplace(myText, findIt, replaceIt)
		
		set findIt to "/"
		set replaceIt to "\\"
		set mylocation to my searchReplace(myText, findIt, replaceIt)
		
		--We copy the newly created path to the clipboard
		set the clipboard to mylocation
		
		tell application "Skype" to activate
		return
	end if
	
	
	
end run



on searchReplace(theText, SearchString, ReplaceString)
	
	set OldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to SearchString
	set newText to text items of theText
	set AppleScript's text item delimiters to ReplaceString
	set newText to newText as text
	set AppleScript's text item delimiters to OldDelims
	
	return newText
end searchReplace

on openPath(myText)
	--We convert myText into a valid path format and we open a new finder window with the new path
	set flag to 0
	set thePath to POSIX path of myText --We change theText to a valid macOS path
	repeat while flag = 0 --We use the flag as an exit for the loop	
		tell application "Finder"
			try
				POSIX file thePath as alias --We check if thePath works, if it doesn't exists, it will go to the error exception
				--If we reached this point, the path works fine so we open it
				set flag to 1 --If we reach this point, the finder could open the path so we exit the loop
				activate "Finder"
				tell application "System Events"
					keystroke "t" using {command down} --We open a new tab
					delay 0.5 --We wait until the tab is open
				end tell
				set target of front window to (thePath as POSIX file)
				
			on error --If the path can't be opened it is probably because it finished with \n, \r or other type of weird characters so we delete them until we can open the path
				if (length of thePath) &lt; 21 then --If we have already cut too many characters we stop the script (we have added /Volumes/BCNMEDIAPROD/
					display dialog "This is not a valid path" with icon caution giving up after 2 buttons ("OK")
					return
				end if
				set thePath to text 1 thru -2 of thePath --We delete the last character until it can be opened
			end try
		end tell
	end repeat
	
	tell application "Finder" to activate
	tell application "Finder" to select front Finder window
	return
	
end openPath

