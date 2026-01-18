/*
 * Holds procs designed to help with filtering text
 * Contains groups:
 *			SQL sanitization
 *			Text sanitization
 *			Text searches
 *			Text modification
 *			Misc
 */


/*
 * SQL sanitization
 */

// Run all strings to be used in an SQL query through this proc first to properly escape out injection attempts.
/proc/sanitizeSQL(var/t as text)
	var/sqltext = dbcon.Quote(t);
	return copytext(sqltext, 2, length(sqltext));//Quote() adds quotes around input, we already do that

/*
 * Text sanitization
 */

/proc/strip_non_ascii(text)
	var/static/regex/non_ascii_regex = regex(@"[^\x00-\x7F]+", "g")
	return non_ascii_regex.Replace(text, "")

/proc/strip_html_simple(t, limit = MAX_MESSAGE_LEN)
	var/list/strip_chars = list("<",">")
	t = copytext(t,1,limit)
	for(var/char in strip_chars)
		var/index = findtextEx(t, char)
		while(index)
			t = copytext(t, 1, index) + copytext(t, index+1)
			index = findtextEx(t, char)
	return t

/**
 * Strip out the special beyond characters for \proper and \improper
 * from text that will be sent to the browser.
 */
#define strip_improper(input_text) replacetext(replacetext(input_text, "\proper", ""), "\improper", "")
var/global/regex/starts_uppercase_regex = regex(@"^[A-Z]")
var/global/regex/starts_lowercase_regex = regex(@"^[a-z]")
#define is_proper(input_text) ((findtextEx(input_text, "\proper") == 1) || findtextEx(input_text, starts_uppercase_regex))
#define is_improper(input_text) ((findtextEx(input_text, "\improper") == 1 || findtextEx(input_text, starts_lowercase_regex)))

/proc/sanitize_PDA(var/msg)
	var/index = findtextEx(msg, "�")
	while(index)
		msg = copytext_char(msg, 1, index) + "&#1103;" + copytext_char(msg, index+1)
		index = findtextEx(msg, "�")
	index = findtextEx(msg, "&#255;")
	while(index)
		msg = copytext_char(msg, 1, index) + "&#1103;" + copytext_char(msg, index+1)
		index = findtextEx(msg, "&#255;")
	return msg

//Used for preprocessing entered text
/proc/sanitize(var/input, var/max_length = MAX_MESSAGE_LEN, var/encode = 1, var/trim = 1, var/extra = 1, var/ascii_only = 0)
	if(!input)
		return

	if(max_length)
		var/input_length = length_char(input)
		if(input_length > max_length)
			to_chat(usr, SPAN_WARNING("Your message is too long by [input_length - max_length] character\s."))
			return
		input = copytext_char(input, 1, max_length + 1)

	input = strip_improper(input)

	if(extra)
		input = replace_characters(input, list("\n"=" ","\t"=" "))

	if(ascii_only)
		// Some procs work differently depending on unicode/ascii string
		// You should always consider this with any text processing work
		// More: http://www.byond.com/docs/ref/info.html#/{notes}/Unicode
		//       http://www.byond.com/forum/post/2520672
		input = strip_non_ascii(input)
	else
		// Strip Unicode control/space-like chars here exept for line endings (\n,\r) and normal space (0x20)
		// codes from https://www.compart.com/en/unicode/category/
		//            https://en.wikipedia.org/wiki/Whitespace_character#Unicode
		var/static/regex/unicode_control_chars = regex(@"[\u0001-\u0009\u000B\u000C\u000E-\u001F\u007F\u0080-\u009F\u00A0\u1680\u180E\u2000-\u200D\u2028\u2029\u202F\u205F\u2060\u3000\uFEFF]", "g")
		input = unicode_control_chars.Replace(input, "")
		// Allows at most one Unicode combining diacritical mark in a row
		// Codes acquired from https://en.wikipedia.org/wiki/Combining_Diacritical_Marks
		//                     https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_Extended
		//                     https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_Supplement
		//                     https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_for_Symbols
		//                     https://en.wikipedia.org/wiki/Combining_Half_Marks
		var/static/regex/unicode_diacritical_marks = regex(@"([\u0300-\u036F\u1AB0-\u1ACE\u1DC0-\u1DFF\u20D0-\u20F0\uFE20-\uFE2F]){2,}", "g")
		input = unicode_diacritical_marks.Replace(input, "$1")


	if(encode)
		// The below \ escapes have a space inserted to attempt to enable Travis auto-checking of span class usage. Please do not remove the space.
		//In addition to processing html, html_encode removes byond formatting codes like "\ red", "\ i" and other.
		//It is important to avoid double-encode text, it can "break" quotes and some other characters.
		//Also, keep in mind that escaped characters don't work in the interface (window titles, lower left corner of the main window, etc.)
		input = html_encode(input)
	else
		//If not need encode text, simply remove < and >
		//note: we can also remove here byond formatting codes: 0xFF + next byte
		input = replace_characters(input, list("<"=" ", ">"=" "))

	if(trim)
		//Maybe, we need trim text twice? Here and before copytext?
		input = trim(input)

	return input

//Run sanitize(), but remove <, >, " first to prevent displaying them as &gt; &lt; &34; in some places after html_encode().
//Best used for sanitize object names, window titles.
//If you have a problem with sanitize() in chat, when quotes and >, < are displayed as html entities -
//this is a problem of double-encode(when & becomes &amp;), use sanitize() with encode=0, but not the sanitize_safe()!
/proc/sanitize_safe(input, max_length = MAX_MESSAGE_LEN, encode = TRUE, trim = TRUE, extra = TRUE, ascii_only = FALSE)
	return sanitize(replace_characters(input, list(">"=" ","<"=" ", "\""="'")), max_length, encode, trim, extra, ascii_only)

/proc/paranoid_sanitize(var/t)
	var/regex/alphanum_only = regex("\[^a-zA-Z0-9# ,.?!:;()]", "g")
	return alphanum_only.Replace(t, "#")

/proc/sanitize_uni(var/t,var/list/repl_chars = list("�"="&#255;"))
	for(var/char in repl_chars)
		var/index = findtextEx(t, char)
		while(index)
			t = copytext_char(t, 1, index) + repl_chars[char] + copytext_char(t, index+1)
			index = findtextEx(t, char)
	return t

//Returns null if there is any bad text in the string
/proc/reject_bad_text(text, max_length=512)
	if(length(text) > max_length)	return			//message too long
	var/non_whitespace = 0
	for(var/i=1, i<=length(text), i++)
		switch(text2ascii(text,i))
			if(62,60,92,47)	return			//rejects the text if it contains these bad characters: <, >, \ or /
			if(127 to 255)	return			//rejects non-ASCII letters
			if(0 to 31)		return			//more weird stuff
			if(32)			continue		//whitespace
			else			non_whitespace = 1
	if(non_whitespace)		return text		//only accepts the text if it has some non-spaces

// Used to get a sanitized input.
/proc/stripped_input(var/mob/user, var/message = "", var/title = "", var/default = "", var/max_length=MAX_MESSAGE_LEN)
	var/name = input(user, message, title, default)
	return strip_html_simple(name, max_length)

//Filters out undesirable characters from names
/proc/sanitizeName(var/input, var/max_length = MAX_NAME_LEN, var/allow_numbers = 0)
	if(!input || length(input) > max_length)
		return //Rejects the input if it is null or if it is longer then the max length allowed

	var/number_of_alphanumeric	= 0
	var/last_char_group			= 0
	var/output = ""

	for(var/i=1, i<=length(input), i++)
		var/ascii_char = text2ascii(input,i)
		switch(ascii_char)
			// A  .. Z
			if(65 to 90)			//Uppercase Letters
				output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 4

			// a  .. z
			if(97 to 122)			//Lowercase Letters
				if(last_char_group<2)		output += ascii2text(ascii_char-32)	//Force uppercase first character
				else						output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 4

			// 0  .. 9
			if(48 to 57)			//Numbers
				if(!last_char_group)		continue	//suppress at start of string
				if(!allow_numbers)			continue	// If allow_numbers is 0, then don't do this.
				output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 3

			// '  -  .
			if(39,45,46)			//Common name punctuation
				if(!last_char_group) continue
				output += ascii2text(ascii_char)
				last_char_group = 2

			// ~   |   @  :  #  $  %  &  *  +
			if(126,124,64,58,35,36,37,38,42,43)			//Other symbols that we'll allow (mainly for AI)
				if(!last_char_group)		continue	//suppress at start of string
				if(!allow_numbers)			continue
				output += ascii2text(ascii_char)
				last_char_group = 2

			//Space
			if(32)
				if(last_char_group <= 1)	continue	//suppress double-spaces and spaces at start of string
				output += ascii2text(ascii_char)
				last_char_group = 1
			else
				return

	if(number_of_alphanumeric < 2)	return		//protects against tiny names like "A" and also names like "' ' ' ' ' ' ' '"

	if(last_char_group == 1)
		output = copytext(output,1,length(output))	//removes the last character (in this case a space)

	for(var/bad_name in list("space","floor","wall","r-wall","monkey","unknown","inactive ai","plating"))	//prevents these common metagamey names
		if(cmptext(output,bad_name))	return	//(not case sensitive)

	return output


//Old variant. Haven't dared to replace in some places.
/proc/sanitize_old(var/t,var/list/repl_chars = list("\n"="#","\t"="#"))
	return html_encode(replace_characters(t,repl_chars))

/*
 * Text searches
 */

//Checks the beginning of a string for a specified sub-string
//Returns the position of the substring or 0 if it was not found
/proc/dd_hasprefix(text, prefix)
	var/start = 1
	var/end = length(prefix) + 1
	return findtextEx(text, prefix, start, end)

//Checks the beginning of a string for a specified sub-string. This proc is case sensitive
//Returns the position of the substring or 0 if it was not found
/proc/dd_hasprefix_case(text, prefix)
	var/start = 1
	var/end = length(prefix) + 1
	return findtextEx(text, prefix, start, end)

//Checks the end of a string for a specified substring.
//Returns the position of the substring or 0 if it was not found
/proc/dd_hassuffix(text, suffix)
	var/start = length(text) - length(suffix)
	if(start)
		return findtextEx(text, suffix, start, null)
	return

//Checks the end of a string for a specified substring. This proc is case sensitive
//Returns the position of the substring or 0 if it was not found
/proc/dd_hassuffix_case(text, suffix)
	var/start = length(text) - length(suffix)
	if(start)
		return findtextEx(text, suffix, start, null)

/*
 * Text modification
 */
/proc/replace_characters(var/t,var/list/repl_chars)
	for(var/char in repl_chars)
		t = replacetext(t, char, repl_chars[char])
	return t

/proc/replaceText(text, find, replacement)
	return list2text(text2list(text, find), replacement)

/proc/replaceTextEx(text, find, replacement)
	return list2text(text2listEx(text, find), replacement)

//Adds 'u' number of zeros ahead of the text 't'
/proc/add_zero(t, u)
	while (length(t) < u)
		t = "0[t]"
	return t

//Adds 'u' number of spaces ahead of the text 't'
/proc/add_lspace(t, u)
	while(length(t) < u)
		t = " [t]"
	return t

//Adds 'u' number of spaces behind the text 't'
/proc/add_tspace(t, u)
	while(length(t) < u)
		t = "[t] "
	return t

//Returns a string with reserved characters and spaces before the first letter removed
/proc/trim_left(text)
	for (var/i = 1 to length(text))
		if (text2ascii(text, i) > 32)
			return copytext(text, i)
	return ""

//Returns a string with reserved characters and spaces after the last letter removed
/proc/trim_right(text)
	for (var/i = length(text), i > 0, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, 1, i + 1)
	return ""

//Returns a string with reserved characters and spaces before the first word and after the last word removed.
/proc/trim(text)
	return trim_left(trim_right(text))

//Returns a string with the first element of the string capitalized.
/proc/capitalize(var/t as text)
	return uppertext(copytext(t, 1, 2)) + copytext(t, 2)

//Returns a string with the first element of the string dcapitalized.
/proc/decapitalize(text)
	if(text)
		text = lowertext(text[1]) + copytext(text, 1 + length(text[1]))
	return text

//Centers text by adding spaces to either side of the string.
/proc/dd_centertext(message, length)
	var/new_message = message
	var/size = length(message)
	var/delta = length - size
	if(size == length)
		return new_message
	if(size > length)
		return copytext_char(new_message, 1, length + 1)
	if(delta == 1)
		return new_message + " "
	if(delta % 2)
		new_message = " " + new_message
		delta--
	var/spaces = add_lspace("",delta/2-1)
	return spaces + new_message + spaces

//Limits the length of the text. Note: MAX_MESSAGE_LEN and MAX_NAME_LEN are widely used for this purpose
/proc/dd_limittext(message, length)
	var/size = length(message)
	if(size <= length)
		return message
	return copytext_char(message, 1, length + 1)

//This proc strips html properly, remove < > and all text between
//for complete text sanitizing should be used sanitize()
/proc/strip_html_properly(var/input)
	if(!input)
		return
	var/opentag = 1 //These store the position of < and > respectively.
	var/closetag = 1
	while(1)
		opentag = findtextEx(input, "<")
		closetag = findtextEx(input, ">")
		if(closetag && opentag)
			if(closetag < opentag)
				input = copytext(input, (closetag + 1))
			else
				input = copytext(input, 1, opentag) + copytext(input, (closetag + 1))
		else if(closetag || opentag)
			if(opentag)
				input = copytext(input, 1, opentag)
			else
				input = copytext(input, (closetag + 1))
		else
			break

	return input

//This proc fills in all spaces with the "replace" var (* by default) with whatever
//is in the other string at the same spot (assuming it is not a replace char).
//This is used for fingerprints
/proc/stringmerge(var/text,var/compare,replace = "*")
	var/newtext = text
	if(length(text) != length(compare))
		return 0
	for(var/i = 1, i < length(text), i++)
		var/a = copytext(text,i,i+1)
		var/b = copytext(compare,i,i+1)
		//if it isn't both the same letter, or if they are both the replacement character
		//(no way to know what it was supposed to be)
		if(a != b)
			if(a == replace) //if A is the replacement char
				newtext = copytext(newtext,1,i) + b + copytext(newtext, i+1)
			else if(b == replace) //if B is the replacement char
				newtext = copytext(newtext,1,i) + a + copytext(newtext, i+1)
			else //The lists disagree, Uh-oh!
				return 0
	return newtext

//This proc returns the number of chars of the string that is the character
//This is used for detective work to determine fingerprint completion.
/proc/stringpercent(var/text,character = "*")
	if(!text || !character)
		return 0
	var/count = 0
	for(var/i = 1, i <= length(text), i++)
		var/a = copytext(text,i,i+1)
		if(a == character)
			count++
	return count

/proc/reverse_text(var/text = "")
	var/new_text = ""
	for(var/i = length(text); i > 0; i--)
		new_text += copytext(text, i, i+1)
	return new_text

/proc/upperrustext(text as text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 223)
			t += ascii2text(a - 32)
		else if (a == 184)
			t += ascii2text(168)
		else t += ascii2text(a)
	t = replacetext(t,"&#255;","�")
	return t


/proc/lowerrustext(text as text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 191 && a < 224)
			t += ascii2text(a + 32)
		else if (a == 168)
			t += ascii2text(184)
		else t += ascii2text(a)
	return t

/proc/rhtml_encode(var/msg)
	var/list/c = text2list(msg, "�")
	if(c.len == 1)
		c = text2list(msg, "&#255;")
		if(c.len == 1)
			return html_encode(msg)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += "&#255;"
		first = 0
		out += html_encode(text)
	return out

/proc/rhtml_encode_paper(var/msg)
	var/list/c = text2list(msg, "�")
	if(c.len == 1)
		c = text2list(msg, "&#1103;")
		if(c.len == 1)
			return html_encode(msg)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += "&#1103;"
		first = 0
		out += html_encode(text)
	return out

/proc/rhtml_decode(var/msg)
	var/list/c = text2list(msg, "�")
	if(c.len == 1)
		c = text2list(msg, "&#255;")
		if(c.len == 1)
			return html_decode(msg)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += "&#255;"
		first = 0
		out += html_decode(text)
	return out

/proc/rhtml_decode_paper(var/msg)
	var/list/c = text2list(msg, "�")
	if(c.len == 1)
		c = text2list(msg, "&#1103;")
		if(c.len == 1)
			return html_decode(msg)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += "&#1103;"
		first = 0
		out += html_decode(text)
	return out


//Used in preferences' SetFlavorText and human's set_flavor verb
//Previews a string of len or less length
/proc/TextPreview(var/string,var/len=40)
	if(length(string) <= len)
		if(!length(string))
			return "\[...\]"
		else
			return string
	else
		return "[copytext_preserve_html(string, 1, 37)]..."

//alternative copytext() for encoded text, doesn't break html entities (&#34; and other)
/proc/copytext_preserve_html(var/text, var/first, var/last)
	return html_encode(copytext(html_decode(text), first, last))

/proc/sql_sanitize_text(var/text)
	text = replacetext(text, "'", "''")
	text = replacetext(text, ";", "")
	text = replacetext(text, "&", "")

//For generating neat chat tag-images
//The icon var could be local in the proc, but it's a waste of resources
//	to always create it and then throw it out.
/var/icon/text_tag_icons = new('./icons/chattags.dmi')
/*/proc/create_text_tag(var/tagname, var/tagdesc = tagname, var/client/C = null)
	if(!(C && C.is_preference_enabled(/datum/client_preference/chat_tags)))
		return tagdesc
	return "<IMG src='\ref[text_tag_icons.icon]' class='text_tag' iconstate='[tagname]'" + (tagdesc ? " alt='[tagdesc]'" : "") + ">"
*/
/proc/contains_az09(var/input)
	for(var/i=1, i<=length(input), i++)
		var/ascii_char = text2ascii(input,i)
		switch(ascii_char)
			// A  .. Z
			if(65 to 90)			//Uppercase Letters
				return 1
			// a  .. z
			if(97 to 122)			//Lowercase Letters
				return 1

			// 0  .. 9
			if(48 to 57)			//Numbers
				return 1
	return 0

/**
 * Strip out the special beyond characters for \proper and \improper
 * from text that will be sent to the browser.
 */
/*/proc/strip_improper(var/text)
	return replacetext(replacetext(text, "\proper", ""), "\improper", "")*/

#define gender2text(gender) capitalize(gender)

//Used for applying byonds text macros to strings that are loaded at runtime
/proc/apply_text_macros(string)
	var/next_backslash = findtextEx(string, "\\")
	if(!next_backslash)
		return string

	var/leng = length(string)

	var/next_space = findtextEx(string, " ", next_backslash + 1)
	if(!next_space)
		next_space = leng - next_backslash

	if(!next_space)	//trailing bs
		return string

	var/base = next_backslash == 1 ? "" : copytext(string, 1, next_backslash)
	var/macro = lowertext(copytext(string, next_backslash + 1, next_space))
	var/rest = next_backslash > leng ? "" : copytext(string, next_space + 1)

	//See http://www.byond.com/docs/ref/info.html#/DM/text/macros
	switch(macro)
		//prefixes/agnostic
		if("the")
			rest = text("\the []", rest)
		if("a")
			rest = text("\a []", rest)
		if("an")
			rest = text("\an []", rest)
		if("proper")
			rest = text("\proper []", rest)
		if("improper")
			rest = text("\improper []", rest)
		if("roman")
			rest = text("\roman []", rest)
		//postfixes
		if("th")
			base = text("[]\th", rest)
		if("s")
			base = text("[]\s", rest)
		if("he")
			base = text("[]\he", rest)
		if("she")
			base = text("[]\she", rest)
		if("his")
			base = text("[]\his", rest)
		if("himself")
			base = text("[]\himself", rest)
		if("herself")
			base = text("[]\herself", rest)
		if("hers")
			base = text("[]\hers", rest)

	. = base
	if(rest)
		. += .(rest)

/**
 * Returns the text if properly formatted, or null else.
 *
 * Things considered improper:
 * * Larger than max_length.
 * * Presence of non-ASCII characters if asci_only is set to TRUE.
 * * Only whitespaces, tabs and/or line breaks in the text.
 * * Presence of the <, >, \ and / characters.
 * * Presence of ASCII special control characters (horizontal tab and new line not included).
 * *//*
/proc/reject_bad_text(text, max_length = 512, ascii_only = TRUE)
	if(ascii_only)
		if(length(text) > max_length)
			return null
		var/static/regex/non_ascii = regex(@"[^\x20-\x7E\u0410-\u044F\u0401\u0451\t\n]")
		if(non_ascii.Find(text))
			return null
	else if(length_char(text) > max_length)
		return null
	var/static/regex/non_whitespace = regex(@"\S")
	if(!non_whitespace.Find(text))
		return null
	var/static/regex/bad_chars = regex(@"[\\<>/\x00-\x08\x11-\x1F]")
	if(bad_chars.Find(text))
		return null
	return text
*/

/**
 * Used to get a properly sanitized input. Returns null if cancel is pressed.
 *
 * Arguments
 ** user - Target of the input prompt.
 ** message - The text inside of the prompt.
 ** title - The window title of the prompt.
 ** max_length - If you intend to impose a length limit - default is 1024.
 ** no_trim - Prevents the input from being trimmed if you intend to parse newlines or whitespace.
*/
/*/proc/stripped_input(mob/user, message = "", title = "", default = "", max_length = MAX_MESSAGE_LEN, no_trim = FALSE)
	var/user_input = input(user, message, title, default) as text|null
	if(isnull(user_input)) // User pressed cancel
		return
	if(no_trim)
		return copytext(html_encode(user_input), 1, max_length)
	else
		return trim(html_encode(user_input), max_length) *///trim is "outside" because html_encode can expand single symbols into multiple symbols (such as turning < into &lt;)
