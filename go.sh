#!/bin/bash

# visit landing page
curl 'https://www.twodollarclick.com/index.php' -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8,he;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Mobile Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Connection: keep-alive' -H 'If-Modified-Since: Thu, 01 Jan 1970 00:00:00 GMT' --compressed -s --cookie-jar /tmp/2dollar > /dev/null

# visit login page
curl 'https://www.twodollarclick.com/index.php?view=login&' -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8,he;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Mobile Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: https://www.twodollarclick.com/index.php' -H 'Connection: keep-alive' --compressed -s --cookie-jar /tmp/2dollar --cookie /tmp/2dollar > /dev/null

# fill & send login
curl 'https://www.twodollarclick.com/index.php?view=login&action=login&' -H 'Origin: https://www.twodollarclick.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8,he;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Mobile Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://www.twodollarclick.com/index.php?view=login&' -H 'Connection: keep-alive' -H 'DNT: 1' --data "returnTo=&id=&ac=prattpanel&step=&ptype=&form_user=$1&form_pwd=$2&ipvoid=1" --compressed -s -L --cookie-jar /tmp/2dollar --cookie /tmp/2dollar > /dev/null

# visit "Get Paid To Click"
sid=$(awk '/c_sid[^2u]/{print $(NF)}' /tmp/2dollar)
sid2=$(awk '/c_sid2/{print $(NF)}' /tmp/2dollar)
siduid=$(awk '/c_siduid/{print $(NF)}' /tmp/2dollar)

curl "https://www.twodollarclick.com/index.php?view=account&ac=click&sid=$sid&sid2=$sid2&siduid=$siduid&" -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8,he;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Mobile Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H "Referer: https://www.twodollarclick.com/index.php?view=account&ac=earn&sid=$sid&sid2=$sid2&siduid=$siduid" -H 'Connection: keep-alive' --compressed -s --cookie-jar /tmp/2dollar --cookie /tmp/2dollar | fgrep '10 seconds' -B 3 | fgrep 'gpt.php' | awk -F "'" '{print $(NF-1)}' > /tmp/2dollar_links

while read path; do
	iframe_path=$(curl "https://www.twodollarclick.com/$path" -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8,he;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Mobile Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H "Referer: https://www.twodollarclick.com/index.php?view=account&ac=click&sid=$sid&sid2=$sid2&siduid=$siduid&" -H 'Connection: keep-alive' --compressed -s --cookie-jar /tmp/2dollar --cookie /tmp/2dollar | fgrep 'gpt.php' | awk -F '"' '{print $4}')
	
	curl "https://www.twodollarclick.com/$iframe_path" -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8,he;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Mobile Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H "Referer: https://www.twodollarclick.com/$path" -H 'Connection: keep-alive' --compressed -s --cookie-jar /tmp/2dollar --cookie /tmp/2dollar

	exit 0
done < /tmp/2dollar_links

